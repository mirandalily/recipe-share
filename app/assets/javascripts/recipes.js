function Recipe = function(id, name, comments) {
  this.id = id;
  this.title = title;
  this.comments = comments;
}

Recipe.prototype.numberOfComments = function(){
  var comments = this.comments;
  return comments;
}

function getRecipeComments(id) {
  $.get("/recipes" + ".json", function(data){
    var recipe = new Recipe(id, data.name, data.description, data.comments);
    var recipeComments = recipe.numberOfComments();
    $(".recipeComments_" + id).text(recipeComments + ' comments');
  });
  return false;
}



$(function(){
  getRecipeComments(id);
})
