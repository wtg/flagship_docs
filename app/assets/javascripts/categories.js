function isCategoryLoaded(cat_class) {
  // Determine if the category has been loaded / shown
  if ($(cat_class).length && $(cat_class).attr("value") == "hidden") {
    return true;
  }
  return false;
}

function hideCategory(cat_class) {
  $(cat_class).css("display", "none");
  $(cat_class).attr("value", "hidden");
}

function showCategory(cat_class) {
  $(cat_class).css("display", "block");
  $(cat_class).attr("value", "shown");
}

// Get all subcategories belonging to the toggled category 
function getSubCategories(category_id) {
  url = "/categories/" + category_id.toString() + "/subcategories";

  $.get(url, function(subcategories) {
    var root_class = '.cat-' + category_id.toString(); 
    var id, cat, cat_class, depth = null;

    for(var i = 0; i < subcategories.length; i++) {
      id = subcategories[i].id.toString();
      name = subcategories[i].name;
      depth = subcategories[i].depth * 10;
      cat_class = '.cat-' + id;

      if (!$(cat_class).length) {
        $(root_class).append(
          "<li value='shown' style='display:block-inline; margin-left:"+depth+"px;' class='cat-"+id+"'> \
            <i class='fa fa-plus-square-o' onclick='getSubCategories("+id+")'></i> \
            <a href='/categories/"+id+"'>"+subcategories[i].name+"</a> \
          </li>"
        );
      } else if (isCategoryLoaded(cat_class)) {
        showCategory(cat_class);
      } else {
        hideCategory(cat_class);
      }
    }
  });
}