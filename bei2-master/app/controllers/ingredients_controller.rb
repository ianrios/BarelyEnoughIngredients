class IngredientsController < ApplicationController
    before_action :find_ingredient, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index]
    #this code displayes the ingredients and their quantities
    def index
        @ingredient= Ingredient.all.order("created_at DESC")
    end
    #this code shows the ingredient and quantity
    def show
    end
    #this code creates a new ingredient
    def new
        # @ingredient = Ingredient.new
        @ingredient = current_user.ingredients.build
    end
    #this code creates a new ingredient with proper quantity
    def create
        # @ingredient= Ingredient.new(ingredient_params)
        @ingredient = current_user.ingredients.build(ingredient_params)
        if @ingredient.save
            redirect_to @ingredient, notice: "Successfully added new ingredient"
        else
            render 'new'
        end
    end
    #this code edits the ingredient name
    def edit
    end
    #this code updates the ingredient quantity
    def update
        if @ingredient.update(ingredient_params)
            redirect_to @ingredient
        else
            render 'edit'
        end
    end
    #this code deletes the ingredient
    def destroy
        @ingredient.destroy
        redirect_to root_path, notice: "Successfully deleted ingredient"
    end

    private
    #this code ensures the correct data is typed into the parameters
    def ingredient_params
        params.require(:ingredient).permit(:name, :quantity)
    end
    #this code finds the ingredient IDs
    def find_ingredient
        @ingredient = Ingredient.find(params[:id])
    end

end
