table = $('.portions table')
table.find("#<%= dom_id resource %>").remove()
table.append("<%= j render 'form_row', portion: resource %>")