
$(document).ready(function() {

  $('.shift_header .name').click(function(e) {
    console.log(e);
    $(e.currentTarget).parent().siblings('.shift_info').toggle();
  });
});