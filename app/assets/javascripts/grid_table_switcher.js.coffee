$('a.update_holder').live 'click', (event) ->
  event.preventDefault()
  target_url = $(this).attr('href')
  $.ajax
    url: target_url
    dataType: 'html'
    cache: false
    success: (data) ->
      $('#doc_holder').fadeOut 100, ->
        $('#doc_holder').html(data).fadeIn('slow')
