/* Recursively hide or show a category and it's sub categories */
function toggleDescendants(root_num, cat_num, depth) {
	// Get all categories under the root
	categories = $("li[data-root='" + root_num.toString() + "']")
		.filter(function() {
			// Filter categories only selecting ones 
			//  at the next depth level and 
			//   with a greater or equal category level
			return $(this).data("cat") >= cat_num 
					&& $(this).data("depth") == depth + 1
		}).each(function() {

			// Show element if hidden
			if ($(this).attr("value") == "hidden") {
				$(this).css("display", "block");
				$(this).attr("value", "shown");
			}
			// Hide element if shown
			else if ($(this).attr("value") == "shown") {
				$(this).css("display", "none");
				$(this).attr("value", "hidden");

				// Hide deeper levels of subcategories beyond the current depth + 1
				$("li[data-root='" + root_num.toString() + "']")
					.filter(function() {
						return $(this).data("cat") > cat_num
								&& $(this).data("depth") > depth + 1
					}).each(function() {
						// Hide the subcategory element
						$(this).css("display", "none");
						$(this).attr("value", "hidden");
					});
			}
	});
}	