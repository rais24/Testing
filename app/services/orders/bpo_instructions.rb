module Orders
  class BpoInstructions < Prawn::Document
    include ActionView::Helpers::NumberHelper

    def initialize order
      super()
      @order = order
      @font_size = 10
      @column_widths_3xview = [145,110,280]
      @column_widths_5xview = [145,110,125,60,100]
      draw_pdf
    end

    private

    def draw_pdf
      text "Order Number: #{@order.id}", size: 24, style: :bold
      move_down 1
      draw_header unless @order.bpo_processor.blank?
      move_down 20
      draw_ingredients if @order.order_products.where(cashback: false).count > 0
      move_down 10 if @order.order_products.count > 0
      draw_delivery_information
      render_file "tmp/#{@order.id}_ingredients.pdf"
    end

  delegate :store_email, :store_password, :password, to: :store

    def draw_header
      header_items_line_1 = [[                        "Website for ordering:",  "#{@order.bpo_processor.store_website}     (Click Sign In)"]]
      header_items_line_2 = [["Guide Step 1",         "E-mail for log-in:",     "#{@order.bpo_processor.store_email}"]]
      header_items_line_3 = [[                        "Password for log-in:",   "#{@order.bpo_processor.store_password}"]]
      header_items_line_4 = [["Guide Step 2",         "Click 'Order Online' -> Shoprite from Home - Order Groceries", ""]]
      store_name = @order.bpo_processor.name || ""
      header_items_line_5 = [["Guide Step 4",         "Zip Code for Store Location:",  "#{@order.bpo_processor.store_zipcode}"]]
      header_items_line_6 = [["Guide Step 5",         "Store for Ordering:",           store_name]]
      header_items_line_7 = [["Guide Step 6",         "Click #{store_name} in the right column", ""]]
      table(header_items_line_1,
        :column_widths => @column_widths_3xview[1..-1],
        :cell_style => { :font => "Times-Roman",:size => @font_size-1,:border_width => [0,0], :padding => [0,0,0,0]},
        :position => :right
      )
      table(header_items_line_2,
        :column_widths => @column_widths_3xview,
        :cell_style => { :font => "Times-Roman",:size => @font_size-1,:border_width => [0,0], :padding => [0,0,0,0]},
        :position => :right
      )
      table(header_items_line_3,
        :column_widths => @column_widths_3xview[1..-1],
        :cell_style => { :font => "Times-Roman",:size => @font_size-1,:border_width => [0,0,1,0], :padding => [0,0,0,0]},
        :position => :right
      )
      table(header_items_line_4,
        :column_widths => @column_widths_3xview,
        :cell_style => { :font => "Times-Roman",:size => @font_size-1,:border_width => [1,0,0,0], :padding => [0,0,0,0]},
        :position => :right
      )
      table(header_items_line_5,
        :column_widths => @column_widths_3xview,
        :cell_style => { :font => "Times-Roman",:size => @font_size-1,:border_width => [0,0,1,0], :padding => [0,0,0,0]},
        :position => :right
      )
      table(header_items_line_6,
        :column_widths => @column_widths_3xview,
        :cell_style => { :font => "Times-Roman",:size => @font_size-1,:border_width => [0,0,1,0], :padding => [0,0,0,0]},
        :position => :right
      )
      table(header_items_line_7,
        :column_widths => @column_widths_3xview,
        :cell_style => { :font => "Times-Roman",:size => @font_size-1,:border_width => [0,0,1,0], :padding => [0,0,0,0]},
        :position => :right
      )
    end

    def draw_ingredients
      table_header = [
        ["Item List for Ordering",
          "Copy and paste SKU into search field to add correct item",
          "Enter the appropriate QUANTITY of each SKU",
          "",
          "Cost may differ slightly based on weekly promotions"
        ]
      ]
      table(table_header,
        :column_widths => @column_widths_5xview,
        :cell_style => {
          :font => "Times-Roman",
          :size => (@font_size+1),
          :font_style => :bold,
          :border_width => [0,0,0,0],
          :padding => [0,0,0,0],
          :align => :center
          },
        :position => :right
      )
      column_headers = [["Brand and Item", "SKU", "Package Size or Amount", "Quantity", "Estimated Total Cost"]]
      table(column_headers,
        :column_widths => @column_widths_5xview,
        :cell_style => {
          :font => "Times-Roman",
          :size => @font_size,
          :font_style => :bold,
          :border_width => [1,1,1,1],
          :padding => [0,0,0,0],
          :align => :center
        },
        :position => :right
      )
      ingredients = @order.order_products.map do |osi|
        [
          "#{osi.brand} #{osi.name}",
          osi.sku,
          "#{osi.sku_quantity}",
          osi.quantity,
          number_to_currency(osi.total_price)
        ]
      end
      total_items = @order.order_products.map(&:quantity).inject(:+) || 0
      ingredients << ["","", "TOTAL ITEMS", total_items, ""]
      table(ingredients,
        :column_widths => @column_widths_5xview,
        :cell_style => {
          :font => "Times-Roman",
          :size => @font_size,
          :border_width => [1,1,1,1],
          :padding => [0,0,0,0],
          :align => :center
        },
        :position => :right
      )
    end

    def draw_delivery_information
      additional_inst = [["GUIDE STEP 15:", "Check 'Allow Substitutions'"]]
      table(additional_inst,
        :column_widths => [@column_widths_3xview[0]+@column_widths_3xview[1], @column_widths_3xview[-1]],
        :cell_style => { :font => "Times-Roman",:size => (@font_size-1), :border_width => [1,0,1,0], :padding => [0,0,0,0]},
        :position => :left
      )
      move_down 10
      comments = [["GUIDE STEP 16: COMMENTS SECTION", "Enter 'order ##{@order.id}'."]]
      table(comments,
        :column_widths => [@column_widths_3xview[0]+@column_widths_3xview[1], @column_widths_3xview[-1]],
        :cell_style => { :font => "Times-Roman",:size => (@font_size-1), :border_width => [1,0,1,0], :padding => [0,0,0,0]},
        :position => :left
      )
      move_down 10
      
      text "GUIDE STEP 17: DELIVERY INFORMATION"
      delivery_address = [
        ["First Name",     "FITLY - #{@order.address.first_name}"],
        ["Last Name",      @order.address.last_name],
        ["Address Line 1", @order.address.street1],
        ["Address Line 2", @order.address.street2],
        ["City",           @order.address.city],
        ["State",          @order.address.state],
        ["Zip/Postal Code",@order.address.zipcode],
        ["Primary Phone",  @order.address.phone],
        ["DO NOT MODIFY BILLING INFORMATION",""]      
      ]
      table(delivery_address,
        :column_widths => @column_widths_3xview[0..1],
        :cell_style => { :font => "Times-Roman",:size => @font_size, :border_width => [0,0,0,0], :padding => [0,0,0,0]},
        :position => :left
      )
      move_down 10
      customer_instructions = @order.comments.blank? ? "" : "2.  #{@order.comments}"
      bpo_processor_account_id = @order.bpo_processor.blank? ? "N/A" : @order.bpo_processor.account_id
      order_delivery_date = (@order.delivery_time.blank? || @order.delivery_time.delivery_date.blank?) ? "N/A" : @order.delivery_time.delivery_date
      order_time_slot = (@order.delivery_time.blank? || @order.delivery_time.time_slot.blank?) ? "N/A" : @order.delivery_time.time_slot
      delivery_schdeule = [
        ["GUIDE STEP 18: ADDITIONAL DELIVERY INSTRUCTIONS", "1. Always call before ringing doorbell and let customer know you have their Fitly order.  #{customer_instructions}"],
        ["GUIDE STEP 19: DELIVERY DATE", order_delivery_date],
        ["GUIDE STEP 20: DELIVERY TIME", order_time_slot],
        ["GUIDE STEP 21: HOUSE ACCOUNT NUMBER", bpo_processor_account_id]
      ]
      table(delivery_schdeule,
        :column_widths => [@column_widths_3xview[0]+@column_widths_3xview[1], @column_widths_3xview[-1]],
        :cell_style => { :font => "Times-Roman",:size => (@font_size-1), :border_width => [1,0,1,0], :padding => [0,0,0,0]},
        :position => :left
      )
    end

  end
end
