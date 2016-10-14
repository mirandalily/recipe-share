$(document).ready(function(e){

  $("#comments-form").submit(function() {
    var values = $(this).serialize();
    $.ajax({
      type: "POST",
      url: $(this).attr("action"),
      data: values,
      dataType: "JSON"
    }).success(function(json) {
      $("#comment").append("<p>" + json.content + "</p>" );
    })
  })
  // $.get(this.href).succes(function(response){
  //   $("div.recipe-comments").html(response)
  // })
  //   e.preventDefault();
  // })
})
