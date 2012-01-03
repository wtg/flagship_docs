$(function() {
  if ($('#flash_block')[0] && $('#flash_block').is(':visible')) {
    setTimeout(function() {
      $('#flash_block').fadeOut('slow', function() {
        $('#flash_block').remove();
      });
    }, 7000);
  }
});
