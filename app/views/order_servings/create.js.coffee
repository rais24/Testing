ele    = $('.recipe[data-id=<%= dom_id(resource.recipe) %>]')
parent = ele.parent()

ele.remove()
parent.append("<%= j render partial: 'recipes/recipe', object: resource.recipe %>")

<%- %w(header-cart sticky-cart).each do |id| %>
container = $("#<%= id %>")
container.children().remove()
container.append('<%= j render "orders/#{id.gsub('-', '_')}", order: @order %>')
<% end %>

checkout = $('#checkout')
parent = checkout.parent()

checkout.remove()
parent.append('<%= j render 'orders/checkout_button', order: @order %>')

ele = $('a.js-submit[data-id=<%= dom_id(resource.recipe) %>]')
ele.replaceWith('<%= j cart_action(resource.recipe) %>')

window.formHooks('<%= dom_id(resource.recipe) %>')