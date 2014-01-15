// $(document).ready(function() {

//   $('[data-comment-button="create"]').on("submit", function(e) {
//     e.preventDefault();
//     $form = $(e.currentTarget);
//     $.ajax({
//       type: "POST",
//       url: $form.attr('action'),
//       dataType: "json"
//     });

//     var comment = $('#comment_body').val();
//     $('#comments').after(comment);
//     $('#comment_body').value = "";
//     $('#comments_count').replaceWith('Total Comments: ' + <%= @project.comments.count %> ); 

//   });

// });