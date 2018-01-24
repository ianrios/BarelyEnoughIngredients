$(document).ready ->
    $("#coolId").click (wow) ->
        $.ajax(url: "/recipes/search", data: {'query':$("#searchId").val()}).done (html) ->
            alert('no dogs ever')
            $("#resultsId").html html
            #this code is testing code


    $("#allRecipesButt").click (wow) ->
        $('#resultsFoodsId').html '<img src="https://media.tenor.com/images/85d269dc9595a7bcf87fd0fa4039dd9f/tenor.gif"></img>'
       	$.ajax(url: "/recipes/findrecipes", data: {'query':$("#searchRecipesId").val().trim()}).done (html) ->
            $("#resultsRecipesId").html html
            #this javascript returns all applicable recipes


    $("#getStepsButt").click (wow) ->
       	$.ajax(url: "/recipes/getsteps", data: {'query':$("#getStepsId").val().trim()}).done (html) ->
            $("#resultsStepsId").html html
            #this code returns the steps for a particular recipe
