window.formHooks = (id) ->
  if id?
    dataId = "[data-id='#{id}']"
  else
    dataId = ''

  checkboxSubmittable = $(".js-checkbox-submit#{dataId}")
  checkboxSubmittable.click (e) ->
    $(this).parents('form:first').submit()

  jsSubmittable = $(".js-submit#{dataId}")
  jsSubmittable.click (e) ->
    e.preventDefault()
    parent = $(this).parents('form:first')
    parent.submit()

  jsClickLockable = $(".js-click-lock#{dataId}")
  jsClickLockable.click (e) ->
    target = $(e.target)
    if target.hasClass 'disabled'
      e.preventDefault()
    else
      target.addClass 'disabled'

$ ->
  window.formHooks()