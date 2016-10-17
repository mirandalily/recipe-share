$(document).ready(function(){
  // $(".recipe").on("click", function(){
  //   var id = $(this).attr("data-id");
  //   recipeInformation(id);
  //   $('#recipe-info-'+id).slideToggle('fast');
  //   e.stopPropagation();
  // });

  $("#comments-form").submit(function() {
    var values = $(this).serialize();
    $.ajax({
      type: "POST",
      url: $(this).attr("action"),
      data: values,
      dataType: "JSON"
    }).success(function(json) {
      console.log("success", json);
      $("#recipe-comments").append("<p>" + json.content + "</p>" );
    });
    return false;
  });
});

function Recipe(id, title, description, directions, comments) {
  this.title = title;
  this.description = description;
  this.directions = directions;
  this.comments = comments;
}

function recipeInformation(id) {
  $.get("recipes/" + id + ".json", function(data) {
    var currentRecipe = new Recipe(id, data.name, data.description, data.directions, data.comments)
  });
  return false;
}
