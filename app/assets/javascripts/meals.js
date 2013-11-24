// wait for all elements to be in page!
var ready = function() {
  var $mealInfoArea = $('#mealInfo');

  $('.meal').click(function(e) {
    var info = $(e.currentTarget).find('.mouseover').html();
    $mealInfoArea.html(info);
  });

  $('.next_meal').click();

  // $('.meal').mouseleave(function(e) {
  //  $mealInfo.html('');
  // });

  var $meal_shift_chk_box = $('.meal_shift_form input.meal_shift_type');
  $.each($meal_shift_chk_box, function(index, box) {
    if ($(box).is(':checked')) {
      $(box).parent().addClass('checked');
      $('#'+$(box).attr('id')+'_details').show();
    } else {
      $('#'+$(box).attr('id')+'_details').hide();
    }
  });


  $meal_shift_chk_box.change(function(e) {
    var $horibar = $(e.target).parent();
    if ($(e.target).is(':checked')) {
      if (!$horibar.hasClass('checked')) {
        $(e.target).parent().addClass('checked');
      }
      $('#'+$(e.target).attr('id')+'_details').show();
    } else {
      if ($horibar.hasClass('checked')) {
      $(e.target).parent().removeClass('checked');
      }
      $('#'+$(e.target).attr('id')+'_details').hide();
    }
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);