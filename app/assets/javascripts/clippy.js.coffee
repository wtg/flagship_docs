root = exports ? this
root.render_clippy = (file, swf='clippy.swf', elem_id='clippy') ->
  flashvars =
    text: file
  params =
    bgcolor: '#EDEDED'
    scale: 'noscale'   
    quality: 'high'
  swfobject.embedSWF swf, elem_id, '110', '14', '9.0.0', '', flashvars, params
