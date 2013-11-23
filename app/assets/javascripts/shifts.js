
var ready = function() {
  $('.shift_header .left_content').click(function(e) {
    $(e.currentTarget).closest('.shift_header').siblings('.shift_info').toggle();
  });

  $('.shift .remove_shift_link').click(function(e) {
  	e.preventDefault();
  	$.get($(e.currentTarget).attr('href'), function(res) {
  		$(e.currentTarget).closest('.shift').remove();
  	});
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);