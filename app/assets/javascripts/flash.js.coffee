$ ->
  if $('#flash_block')[0] and $('#flash_block').is(':visible')
    setTimeout ->
      $('#flash_block').fadeOut 'slow', ->
        $('#flash_block').remove()
    , 7000

