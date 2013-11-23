// wait for all elements to be in page!
var ready = function() {
	var $mealInfoArea = $('#mealInfo');

	$('.meal').click(function(e) {
		var info = $(e.currentTarget).find('.mouseover').html();
		$mealInfoArea.html(info);
	});

	// $('.meal').mouseleave(function(e) {
	// 	$mealInfo.html('');
	// });

	var $meal_shift_chk_box = $('.meal_shift_form input.meal_shift_type');
	$.each($meal_shift_chk_box, function(index, box) {
		if ($(box).is(':checked')) {
			$('#'+$(box).attr('id')+'_details').show();
		} else {
			$('#'+$(box).attr('id')+'_details').hide();
		}
	});


	$meal_shift_chk_box.change(function(e) {
		if ($(e.target).is(':checked')) {
			$('#'+$(e.target).attr('id')+'_details').show();
		} else {
			$('#'+$(e.target).attr('id')+'_details').hide();
		}
	});
};

$(document).ready(ready);
$(document).on('page:load', ready);