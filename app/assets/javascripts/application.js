// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){
  $('[data-vote-button="create"]').on('submit', function(e){
    e.preventDefault();
    $form = $(e.currentTarget);
    $.ajax({
      type: "POST",
      url: $form.attr('action'),
      dataType: "json",
      success: function(score){
        $('.votes_size').html("<strong>Score: </strong>" + score);
      }
    });
  });

  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    $form = $(e.currentTarget);
    $data = $('#new_comment').serialize();
    $.ajax({
      type: "POST",
      url: $form.attr('action'),
      data: $data,
      dataType: "json",
      success: function(comment) {
        date = new Date(comment.comment.created_at);
        $('#comments').append("<strong>" + comment.user + "</strong><em> on " + date + "</em><br>" + comment.comment.body + "<br><br><a id=\"ajax_comment\" data-method=\"delete\" href=\"/projects/" + comment.comment.project_id + "/comments/" + comment.comment.id + "\" rel=\"nofollow\">Delete</a><hr>");
        document.getElementById('comment_body').value = "";
      }
    });
  });

  // $('#ajax_comment').on('click', function(e){
  //   alert('At least this works...');
  //   e.preventDefault();
  //   $link = $(e.currentTarget);
  //   console.log($link);
  //   $.ajax ({
  //     type: "POST",
  //     url: $link.attr('action'),
  //     dataType: "json",
  //     success: function(comment) {
  //       console.log(comment);
  //     }
  //   });
  // });

});

