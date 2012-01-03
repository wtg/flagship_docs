$('a.update_holder').live('click', function(event) {
  event.preventDefault();
  target_url = $(this).attr('href');
  $.ajax({
    url: target_url,
    dataType: 'html',
    cache: false,
    success: function(data) {
      $('#doc_holder').fadeOut(100, function() {
        $('#doc_holder').html(data).fadeIn('slow');
      });
    }
  });
});
