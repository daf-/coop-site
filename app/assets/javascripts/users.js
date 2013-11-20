var ready = function() {

  $('.shift_toggle').click(function(e) {
    e.preventDefault();
    var link = $(e.currentTarget).find('.add_remove_link');
    $.get(link.attr('href'), function(res) {
      if (res.alert) {
        $('#alert').html(res.html);
      } else {
        $(e.currentTarget).html(res);
      }
    });
  });

};

$(document).ready(ready);
$(document).on('page:load', ready);