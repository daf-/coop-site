var ready = function() {
  $('.swap_request').click(function(e) {
    $(e.currentTarget).closest('.swap_request').find('.bottom_content').toggle();
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);
