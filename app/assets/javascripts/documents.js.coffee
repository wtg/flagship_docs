$(document).on 'click', '#revision-link', (event) ->
  event.preventDefault()
  $('#revision-link').fadeOut 'fast', ->
    $('#new-revision').fadeIn 'fast'

