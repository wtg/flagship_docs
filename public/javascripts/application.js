// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function () {
	$("#search-jQuery").css({'display' : 'block'});
	$("#search_query").bind('keyup',function () {
		$.ajax({
			type: "POST",
			cache: true,
			url: baseURL + "/documents/auto_complete_for_search_query",
			data: $(this),
			success: function(msg) {
				$("#search_query_auto_complete").show();
				$("#search_query_auto_complete").html(msg);
			}
		});
	});

	$('#searchbox'.parent).click(function() {
		$("#search_query_auto_complete").hide();
	});

});




