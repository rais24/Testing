<% portions = parent.portions.send(resource.category) %>
<% included = portions.included %>
<% excluded = portions.excluded %>

parent = $("#included-<%= resource.category %>")
parent.children().remove()
parent.append('<%= j render included %>')

container = $('#excluded-portions')
container.children().remove()
container.append('<%= j render excluded %>')

label = $('#excluded-label')
<% if excluded.empty? %>
label.addClass('hidden')
<% else %>
label.removeClass('hidden')
<% end %>

window.formHooks()