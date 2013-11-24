var ready = function() {

  $('.shift_toggle').click(function(e) {
    e.preventDefault();
    var link = $(e.currentTarget).find('.add_remove_link');
    $.get(link.attr('href'), function(res) {
      var reshtml = $(res);
      if (reshtml.hasClass('pic_confirm_deny')) {
        $('#alert_area').html(res);
        $('#alert_area').show();
        watchAlertArea(e.currentTarget);
        $('#shift_select_page').addClass('background');
      } else {
        $(e.currentTarget).html(res);
      }
    });
  });

  function watchAlertArea(origCell) {
    $('#alert_area a').click(function(e) {
      e.preventDefault();
      $.get($(e.currentTarget).attr('href'), function(res) {
        $('#alert_area').html('');
        $('#alert_area').hide();
        $('#shift_select_page').removeClass('background');
        $(origCell).html(res);
      });
    });
  }

};

$(document).ready(ready);
$(document).on('page:load', ready);