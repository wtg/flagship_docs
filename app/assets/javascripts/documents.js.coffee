$('#revision-link').live 'click', (event) ->
  event.preventDefault()
  $('#revision-link').fadeOut 'fast', ->
    $('#new-revision').fadeIn 'fast'

