$(function() {

$("#revision-link").click((function(event){
event.preventDefault();
$("#revision-link").fadeOut("slow",function() {
$("#new-revision").fadeIn("slow");
});
}));

											
});
