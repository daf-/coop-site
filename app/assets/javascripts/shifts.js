
var ready = function() {
  $('.shift_header .name').click(function(e) {
    $(e.currentTarget).parent().siblings('.shift_info').toggle();
  });

  $('.shift .remove_shift_link').click(function(e) {
  	e.preventDefault();
  	$.get($(e.currentTarget).attr('href'), function(res) {
  		$(e.currentTarget).parent().remove();
  	});
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);