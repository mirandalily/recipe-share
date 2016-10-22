$(function(){
  $(".js-more").on("click", function() {
    var id = $(this).attr('data-id');
    getRecipe(id);
  });
});

function Recipe(id, title, description, comments) {
  this.title = title;
  this.description = description;
  this.comments = comments;

  this.descriptionInfo = function() {
    var description = this.description;
    return description;
  }
}



function getRecipe(id) {
  $.get("recipes/" + id + ".json", function(data) {
    console.log(data)
    var recipe = new Recipe(id, data.name, data.description, data.comments)
    console.log(recipe)
    var description = recipe.descriptionInfo();
    $(".recipeDescription_" + id).text(description);
  });
}
