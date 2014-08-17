// Show all descendant categories of the clicked parent category
function toggleDescendants(parent_id) {
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
	}
}