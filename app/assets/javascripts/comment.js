$(function() {
  $("#new_comment").on("submit", function(e) {
    $.ajax({
      type: "POST",
      url: this.action,
      data: $(this).serialize(),
      success: function(response) {
        $("#comment_content").val("");
        var $ul = $("div#comments ul")
        $ul.append(response);
      }
    });
    e.preventDefault();
  });


  // $.get(this.url).success(function(json) {
  //   debugger
  //   var $ul = $("div#comments p")
  //   $ul.html("") //empties div
  //   json.forEach(function(comment) {
  //     $ul.append("<li>" + comment.content + "</li>")
  //   })
  // })
});
