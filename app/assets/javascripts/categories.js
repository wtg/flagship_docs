function adjustNavSize() {
  var height = $(window).height() - 25; 
  console.log("Adjusting categories nav height to: " + height);
  $("#categories_nav").height(height);
}

$(window).resize(adjustNavSize);
$(document).ready(adjustNavSize);