$(document).ready(function () {
	//Search box live search
	$("#search-jQuery").css({'display' : 'block'});
	$("#search_query").bind('keyup',function () {
		if($(this).val().length == 0){
			$("#search_query_auto_complete").fadeOut(100);
			$("#search_query_auto_complete").html("");
		} else {
			$.ajax({
				type: "POST",
				cache: true,
				url: searchURL,
				data: $(this),
				success: function(msg) {
					$("#search_query_auto_complete").fadeIn(100);
					$("#search_query_auto_complete").html(msg);
				}
			});
		}
	});

	$('#searchbox'.parent).click(function() {
		$("#search_query_auto_complete").fadeOut(300);
	});
	//End search box

	//Expandable category tree
	$('#cat_tree_expand').click(function() {
		$('#cat_tree_inset').toggle();
		if ($('#label_show').css("display") == "none") {   // case PREVIOUSLY CLOSED
			$('#label_hide').hide();
			$('#label_show').show();
		} else {                                          // case PREVIOUSLY OPEN
			$('#label_show').hide();
			$('#label_hide').show();
		}
		return false;
	});
	$('.info_box p img').tipsy({gravity: 's'});
	//End category tree
});




