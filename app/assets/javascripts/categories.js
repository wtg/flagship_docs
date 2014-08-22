// Show all descendant categories of the clicked parent category
function toggleDescendants(parent_id, position) {
	// Target class for the subcategories and their states (hidden or shown)
	target_class = '.parent-id-' + parent_id.toString();
	target_class_state = $(target_class).attr("value");
	// Class for the tree menu's collapse/show subcategories button 
	button_class = "button-id-" + parent_id.toString();

	if (target_class_state == "hidden") {
		// Show the hidden subcategories
		$(target_class).css("display", "block");
		$(target_class).attr("value", "shown");
		// Change the orientation of the collapsible menu button
		$("." + button_class).attr("class", "fa fa-minus-square-o " + button_class);
	}
	else if (target_class_state == "shown") {
		// Hide the subcategories
		$(target_class).css("display", "none");
		$(target_class).attr("value", "hidden");
		// Change the orientation of the collapsible menu button
		$("." + button_class).attr("class", "fa fa-plus-square-o " + button_class);
		// Recursively hide any remaining categories deeper in the tree
		hideDescendantTree(parent_id + 1, position);
	}
}

function hideDescendantTree(parent_id, position) {
	// Recursively hide any sub categories in the tree
	target_class = '.parent-id-' + parent_id.toString() + ".order-" + position.toString();
	target_class_state = $(target_class).attr("value");
	button_class = "button-id-" + parent_id.toString();

	// Check if the the target class exists
	if ($(target_class).length) {
		if ($(target_class_state == "shown")) {
			// Hide the category
			$(target_class).css("display", "none");
			$(target_class).attr("value", "hidden");
			// Change the toggle button
			$("." + button_class).attr("class", "fa fa-plus-square-o " + button_class);
			// Recurse
			hideDescendantTree(parent_id + 1, position);
		}
	} else {
		// We've reached the end of the tree, return
		return;
	}
}