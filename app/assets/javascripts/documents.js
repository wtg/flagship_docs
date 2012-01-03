$('#revision-link').live('click', function(event) {
  event.preventDefault();
  $('#revision-link').fadeOut('fast', function() {
    $('#new-revision').fadeIn('fast');
  });
});

