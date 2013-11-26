var ready = function() {
  $('.swap_request .top_content').click(function(e) {
    console.log("clicked");
    $(e.currentTarget).closest('.swap_request').find('.bottom_content').toggle();
  });

  // Let jQuery handle the get request
  $('.shift .swap_shift_link').click(function(e) {
    e.preventDefault();
    $.get($(e.currentTarget).attr('href'), function(res) {
      $('#swap_form_holder').show();
      $('#swap_form_holder').html(res);
    });
  });


  $('.swap_request .resolve_swap_request').click(function(e) {
    e.preventDefault();
    $.get($(e.currentTarget).attr('href'), function(res) {
      $(e.currentTarget).closest('.swap_request').remove();
    });
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);
