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
  $('.js-more').on('click', function() {
    $('.recipeDescription_' + id).stop(true).slideToggle('slow');
  });

  $.get("recipes/" + id + ".json", function(data) {
    var recipe = new Recipe(id, data.recipe.name, data.recipe.description, data.recipe.comments)
    console.log(recipe)
    var description = recipe.descriptionInfo();
    $(".recipeDescription_" + id).text(description);
  });

}
