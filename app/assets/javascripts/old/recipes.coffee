$ ->
  return if (!window.print)
  $('a.button-print').removeClass('hide')
  $('a.button-print').click (e) ->
    e.preventDefault()
    window.print()

###
- RESETS
----------------------------------------------
###
$('input, textarea').focus( ->
  elm   = $(@)
  value = elm.val()
  old   = elm.data("placeholder")

  unless old?
    elm.data("placeholder", value)
    old = value
  else if old is value
    elm.val("")

).blur(->
  elm = $(@)

  if elm.val() is ""
    elm.val(elm.data("placeholder"))
)
