require 'unirest'

class RecipesController < ApplicationController
  def list
  end

  def search
  render plain: "bazinga " + params['query'].inspect
  end

  def foods
  end

	def steps
	end
	#this function displays the proper steps for the recipe
  def getsteps
		@hide_menu = true

    puts "In Steps"
    recId = params['query'].inspect
    #this is the link to the API
    url = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/" + recId[1..-2] + "/analyzedInstructions?stepBreakdown=true"
    stepss = Unirest.get url,
      headers:{
        "X-Mashape-Key" => "UpZLcnOR83mshtXvuIOPFXBkfhn5p1UWi1ejsnsTLWoVXrOppm",
        "Accept" => "application/json"
      }
    allSteps = stepss.body

    recSteps = Hash.new

    counter = 1
    #this is how the recipe information is formatted
    allSteps.each do |key|
      key.each do |key2,steps|
        if(key2.eql? "steps")
          steps.each do |step|
            step.each do |key3, lastStep|
              if(key3.eql? "step")
                recSteps[counter] = lastStep
                counter += 1
                #this gives each step a number, for ease of use
              end
            end
          end
        end
      end
    end
    puts recSteps

    @recipeData = recSteps
    render template: "recipes/data3"
  end
  #this function displays the recipes on the recipe search page
  def findrecipes
		@hide_menu = true
    puts "In Find Recipes"
    #this is where the data for the searching of recipes gets routed into
    input = params['query'].inspect

    ingreds = input.split(',')

    input = ingreds.join("%2C")
    #this is the api 
    url = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/findByIngredients?fillIngredients=false&ingredients=" +  input + "&limitLicense=false&number=5&ranking=1"

    res = Unirest.get url,
      headers:{
        "X-Mashape-Key" => "UpZLcnOR83mshtXvuIOPFXBkfhn5p1UWi1ejsnsTLWoVXrOppm",
        "Accept" => "application/json"
      }

    recipes = res.body
    #for each recipe that gets returned, the following information is routed into the recipe results page
    recipes.each do |recipe|
      url2 = url2 = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/" + recipe['id'].to_s + "/information?includeNutrition=false"

      res2 = Unirest.get url2,
      headers:{
        "X-Mashape-Key" => "UpZLcnOR83mshtXvuIOPFXBkfhn5p1UWi1ejsnsTLWoVXrOppm",
        "Accept" => "application/json"
      }

      price = ("$" + (0.01 * res2.body['pricePerServing']).to_s)[0..5]

      recipe['price'] = price
      #this is the price of a recipe per serving

    end

    @recipeData = recipes
    render template: "recipes/data"
  end
end
