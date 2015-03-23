module Orders
  class RecipeInstructions < Prawn::Document
    include ActionView::Helpers::NumberHelper
    include RecipesHelper

    def initialize order
      super()
      @order = order
      @fonts = {
        header:  { size: 10, name: "Times-Roman", style: :normal },
        recipe:  { 
          title:        {size: 22, name: "Times-Roman", style: :bold },
          ingredients:  {size: 9.5, name: "Times-Roman", style: :italic },
          instructions: {size: 10, name: "Times-Roman", style: :bold }
        },
        summary: { size: 12, name: "Times-Roman", style: :italic }
      }
      draw_pdf
    end

    private

    def draw_pdf
      unless @order.user.blank?
        @order.servings.map(&:recipe).each_with_index do |recipe, index|
          draw_recipe(recipe, index)
          start_new_page unless index == (@order.recipes.count - 1)
        end
      end
      render_file "tmp/#{@order.id}_recipes.pdf"
    end

    def draw_recipe(recipe, index)
      text "<u>#{recipe.name}</u>", size: @fonts[:recipe][:title][:size], style: @fonts[:recipe][:title][:style], :inline_format => true, :align => :center
      move_down 10
      draw_image(recipe)
      draw_summary(recipe)
      draw_ingredients(recipe)
      draw_instructions(recipe)
      draw_footer(recipe, index)
    end

    def draw_footer(recipe, index)
      formatted_text_box [ { :text => "#{@order.user_name}   -   Order: #{@order.id}   -   Recipe #{index+1} of #{@order.recipes.count}", 
        :font => @fonts[:header][:name], :styles => [:bold], :size =>  @fonts[:header][:size] }],
      :at => [150, 10], :min_font_size => @fonts[:header][:size], :overflow => :shrink_to_fit      
    end

    def draw_image(recipe)
      image Paperclip.io_adapters.for(recipe.photo), :height => 180 unless recipe.photo.blank?
    end

    def draw_summary(recipe)
      recipe_summary = ["#{recipe.prep_time + recipe.cook_time} minutes from prep to plate"]
      recipe_summary << "#{recipe.calories} calories"
      recipe_summary << "#{recipe.fat} fat"
      recipe_summary << "#{recipe.carbs} carbs"
      formatted_text_box [ { :text => recipe_summary.join("\n\n"), :font => @fonts[:summary][:name], :styles => [@fonts[:summary][:style]], :size =>  @fonts[:summary][:size] }],
      :at => [380, 670], :width => 200, :min_font_size => @fonts[:summary][:size], :overflow => :shrink_to_fit      

    end

    def draw_ingredients(recipe)
      serving_ingredients = []
      serving = @order.servings.where(recipe: recipe).first
      unless serving.blank?
        serving_ingredients = serving.recipe.portions.collect { |ingredient| "#{ingredient.to_display_amount( serving.quantity )} #{ingredient.name}, #{ingredient.additional_instructions}" }
        serving_ingredients.insert(0, "Number of plates: #{serving.quantity}\n\n")
      end
      formatted_text_box [ { :text => serving_ingredients.join("\n\n"), :font => @fonts[:recipe][:ingredients][:name], :styles => [@fonts[:recipe][:ingredients][:style]], :size =>  @fonts[:recipe][:ingredients][:size] }],
      :at => [0, 480], :width => 170, :min_font_size => @fonts[:recipe][:ingredients][:size], :overflow => :shrink_to_fit      
      #recipe.portions.each do |ing|
        #text show_ingredient_string(ing)
        #move_down 1
      #end
    end

    def draw_instructions(recipe)
      formatted_text_box [ { :text => recipe.steps.join("\n\n"), :font => @fonts[:recipe][:instructions][:name], :size =>  @fonts[:recipe][:instructions][:size] }],
      :at => [200, 480], :width => 350, :min_font_size => @fonts[:recipe][:instructions][:size], :overflow => :shrink_to_fit      
      #recipe.steps.each do |step|
        #text step, size: @fonts[:recipe][:instructions][:size], style: @fonts[:recipe][:instructions][:style]
        #text_box step, size: @fonts[:recipe][:instructions][:size], style: @fonts[:recipe][:instructions][:style]
        #move_down 1
      #end
    end

  end
end
