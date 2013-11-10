// wait for all elements to be in page!
$(document).ready(function() {
	var $mealInfoArea = $('#mealInfo');

	$('.meal').mouseover(function(e) {
		var info = $(e.target).find('.mouseover').html();
		$mealInfoArea.html(info);
	});

	// $('.meal').mouseleave(function(e) {
	// 	$mealInfo.html('');
	// });
});