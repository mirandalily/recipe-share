var Recipe = function(recipe) {
  this.id = recipe.id;
  this.title = recipe.title;
  this.comments = recipe.comments;
}

Recipe.prototype.numberOfComments = function(){
  var output = '<a href="/recipes/' + this.id + '" class="js-comments-show" id="comments-' + this.id + '">';
  var output += this.comments + ' comments';
  var output += '</a>';
  return output
}



function indexRecipeInfo(id) {
  $.get("recipes/" + id + ".json", function(data) {
    var currentRecipe = new Recipe(id, data.title, data.description, data.comments)
    var recipeComments = currentRecipe.numberOfComments();
    $(".recipe-comments" + id).append(recipeComments + ' comments');
  });
  return false;
}


var setupRecipes = function() {
  $.get('/recipes.json').done(function(data) {
    var recipes = indexRecipeInfo();
    recipes = '<div class="com_num">'
  })
}
