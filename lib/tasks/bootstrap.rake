namespace :bootstrap do
  namespace :create do
    desc 'create basic user'
    task users: :environment do
      User.destroy_all
      User.create! email: 'admin@fitly.org', password: "pwd1", password_confirmation: 'pwd1',
                   first: 'adrian', last: 'last', zipcode: '19019', locked: false, role: 'admin'
    end
    desc 'create store ingredients'
    task store_ingredients: :environment do
      #StoreIngredient.destroy_all
      ImportIngredients.import Rails.root.join('public', 'seed', 'shoprite-ingredients.csv')

      StoreIngredient.create!(friendly_name: "Cheese Ravioli", brand_and_item: "ShopRite", sku: "041190403431", amount: 1.0, unit: "unit", price: Money.new(299))
      StoreIngredient.create!(friendly_name: "Onion", brand_and_item: "ShopRite", sku: "000000046664", amount: 1.0, unit: "unit", price: Money.new(299))
      StoreIngredient.create!(friendly_name: "Green Bell Pepper", brand_and_item: "ShopRite", sku: "000000040655", amount: 1.0, unit: "unit", price: Money.new(299))
      StoreIngredient.create!(friendly_name: "Red Bell Pepper", brand_and_item: "ShopRite", sku: "000000040884", amount: 1.0, unit: "unit", price: Money.new(299))
      StoreIngredient.create!(friendly_name: "Yellow Bell Pepper", brand_and_item: "ShopRite", sku: "000000046893", amount: 1.0, unit: "unit", price: Money.new(299))
      StoreIngredient.create!(friendly_name: "Chicken Broth - low sodium", brand_and_item: "ShopRite", sku: "041190046553", amount: 192.0, unit: "tsp", price: Money.new(299))
      StoreIngredient.create!(friendly_name: "Sea Salt - fine", brand_and_item: "Morton", sku: "024600010931", amount: 105.6, unit: "tsp", price: Money.new(299))
      StoreIngredient.create!(friendly_name: "Zucchini", brand_and_item: "ShopRite", sku: "000000040679", amount: 1.0, unit: "unit", price: Money.new(299))

      # garlic
      # 1 clove = 1 tsp, 1 tsp = 1/6 oz
      #StoreIngredient.create!(name: "Garlic", brand: "ShopRite", sku: "041190017645", amount: 1.0, unit: "unit", price: 299)
      # lemons
      #StoreIngredient.create!(name: "Lemon", brand: "", sku: "000000040532", amount: 1.0, unit: "unit", price: 299)

      # fresh thyme
      #StoreIngredient.create!(name: "Thyme Leaves", brand: "Goodness Gardens", sku: "021985200216", amount: 1.5, unit: "tsp", price: Money.new(299))
      # pepper
      #StoreIngredient.create!(name: "Black Pepper - Pure Ground", brand: "ShopRite", sku: "041190032013", amount: 6.0, unit: "tsp", price: Money.new(299))
    end
    desc 'create basic recipes'
    task ingredients: :environment do
      #Recipe.destroy_all
      #Ingredient.destroy_all
      #ShoppingCart.destroy_all
      #Order.destroy_all

      cheese_ravioli = Ingredient.create! name: "Cheese Ravioli", price: Money.new(100), unit: 'unit', category: 'produce', measurement_type: 'solid',
                                  photo: File.open(Rails.root.join('public', 'seed', 'ingredients', "cheese_ravioli.jpg"))
      olive_oil = Ingredient.create! name: "Olive Oil", price: Money.new(100), unit: 'tsp', category: 'produce', pantry: false, measurement_type: 'liquid',
                                  photo: File.open(Rails.root.join('public', 'seed', 'ingredients', 'olive_oil.jpg'))
      onion = Ingredient.create! name: "Yellow Onion", price: Money.new(100), unit: 'unit', category: 'produce', measurement_type: 'solid',
                                  photo: File.open(Rails.root.join('public', 'seed', 'ingredients', "onion.jpg"))
      green_pepper = Ingredient.create! name: "Green Bell Pepper", price: Money.new(100), unit: 'unit', category: 'produce', measurement_type: 'solid',
                                  photo: File.open(Rails.root.join('public', 'seed', 'ingredients', "green_pepper.jpg"))
      red_pepper = Ingredient.create! name: "Red Bell Pepper", price: Money.new(100), unit: 'unit', category: 'produce', measurement_type: 'solid',
                            photo: File.open(Rails.root.join('public', 'seed', 'ingredients', "red_pepper.jpg"))
      yellow_pepper = Ingredient.create! name: "Yellow Bell Pepper", price: Money.new(100), unit: 'unit', category: 'produce', measurement_type: 'solid',
                                  photo: File.open(Rails.root.join('public', 'seed', 'ingredients', "yellow_pepper.jpg"))
      chicken_broth = Ingredient.create! name: "Chicken Broth", price: Money.new(100), unit: 'tsp', category: 'groceries', pantry: false, measurement_type: 'liquid',
                                  photo: File.open(Rails.root.join('public', 'seed', 'ingredients', "chicken_broth.jpg"))
      # ground_red_pepper_flakes = Ingredient.create! name: "ground red pepper flakes", price: Money.new(100), unit: 'tsp', category: 'produce',
      #                             photo: File.open(Rails.root.join('public', 'seed', 'ingredients', "ground_red_pepper.jpg"))
      sea_salt = Ingredient.create! name: "Sea Salt", price: Money.new(100), unit: 'tsp', category: 'produce', pantry: false, measurement_type: 'solid',
                                  photo: File.open(Rails.root.join('public', 'seed', 'ingredients', "sea_salt.jpg"))
      # pepper = Ingredient.create! name: "pepper", price: Money.new(100), unit: 'tsp', category: 'groceries', pantry: true,
      #                             photo: File.open(Rails.root.join('public', 'seed', 'ingredients', 'pepper.jpg'))
      zucchini = Ingredient.create! name: "Zucchini", price: Money.new(100), unit: 'unit', category: 'produce', measurement_type: 'solid',
                                  photo: File.open(Rails.root.join('public', 'seed', 'ingredients', "zucchini.jpg"))
      # --
      chicken = Ingredient.create! name: "Chicken Breast", price: Money.new(100), unit: 'oz', category: 'meats', pantry: false, measurement_type: 'solid',
                                  photo: File.open(Rails.root.join('public', 'seed', 'ingredients', 'chicken_breast.jpg'))
      garlic_clove = Ingredient.create! name: "Garlic Clove", price: Money.new(100), unit: 'unit', category: 'groceries', pantry: false, measurement_type: 'solid',
                                  photo: File.open(Rails.root.join('public', 'seed', 'ingredients', "garlic_clove.jpg"))
      lemon = Ingredient.create! name: "Lemon", price: Money.new(100), unit: 'unit', category: 'groceries', pantry: false, measurement_type: 'solid',
                                  photo: File.open(Rails.root.join('public', 'seed', 'ingredients', "lemon.jpg"))
      thyme = Ingredient.create! name: "Thyme", price: Money.new(100), unit: 'tsp', category: 'groceries', pantry: true, measurement_type: 'solid',
                                  photo: File.open(Rails.root.join('public', 'seed', 'ingredients', "thyme.jpg"))
      #--
      scallion = Ingredient.create! name: 'Scallions', price: Money.new(100), unit: 'unit', category: 'produce', pantry: false, measurement_type: 'solid',
                                  photo: File.open(Rails.root.join('public', 'seed', 'ingredients', "thyme.jpg"))
      ginger = Ingredient.create! name: 'Ginger', price: Money.new(100), unit: 'unit', category: 'produce', pantry: false, measurement_type: 'solid',
                                  photo: File.open(Rails.root.join('public', 'seed', 'ingredients', "thyme.jpg"))
      cilantro = Ingredient.create! name: 'Cilantro', price: Money.new(100), unit: 'unit', category: 'produce', pantry: false, measurement_type: 'solid',
                                  photo: File.open(Rails.root.join('public', 'seed', 'ingredients', "cilantro.jpg"))
      celery = Ingredient.create! name: 'Celery', price: Money.new(100), unit: 'unit', category: 'produce', pantry: false, measurement_type: 'solid',
                                  photo: File.open(Rails.root.join('public', 'seed', 'ingredients', "cilantro.jpg"))
      bok_choy = Ingredient.create! name: 'Bok Choy', price: Money.new(100), unit: 'oz', category: 'produce', pantry: false, measurement_type: 'solid',
                                  photo: File.open(Rails.root.join('public', 'seed', 'ingredients', "cilantro.jpg"))
      red_curry_paste = Ingredient.create! name: 'Red Curry Paste', price: Money.new(100), unit: 'tsp', category: 'groceries', pantry: false, measurement_type: 'solid',
                                  photo: File.open(Rails.root.join('public', 'seed', 'ingredients', "cilantro.jpg"))
      pearled_barley = Ingredient.create! name: 'Pearled Barley', price: Money.new(100), unit: 'tsp', category: 'groceries', pantry: true, measurement_type: 'solid',
                                  photo: File.open(Rails.root.join('public', 'seed', 'ingredients', "cilantro.jpg"))
      can_coconut_milk = Ingredient.create! name: 'Can Coconut Milk', price: Money.new(100), unit: 'unit', category: 'groceries', pantry: false, measurement_type: 'liquid',
                                  photo: File.open(Rails.root.join('public', 'seed', 'ingredients', "cilantro.jpg"))
      salmon_filet = Ingredient.create! name: 'Salmon Filet', price: Money.new(100), unit: 'oz', category: 'meats', pantry: false, measurement_type: 'solid',
                                  photo: File.open(Rails.root.join('public', 'seed', 'ingredients', "salmon_filet.jpg"))
      rice_flour = Ingredient.create! name: 'Rice Flour', price: Money.new(100), unit: 'tsp', category: 'groceries', pantry: true, measurement_type: 'solid',
                                  photo: File.open(Rails.root.join('public', 'seed', 'ingredients', "salmon_filet.jpg"))

      blue_coconut_curry_salmon = Recipe.create! name: "Coconut Curry Salmon Steaks",
      description: "Blatantly stealing this recipe from blue apron",
      prep_time: 55,
      published: true,
      photo: File.open(Rails.root.join('public', 'seed', 'recipes', 'blue_coconut_salmon.jpg')),
      preparation:"get ready to prepare!",
      nutrition: "not null"
      # 48 tsp/cup
      blue_coconut_curry_salmon.portions.create   [{ingredient: garlic_clove, quantity: (6.0 / 4.0)},
                                       {ingredient: scallion, quantity: (4.0/4.0)}, #repeated
                                       {ingredient: ginger, quantity: (2.0/4.0)},
                                       {ingredient: cilantro, quantity: (2.0/4.0)},
                                       {ingredient: lemon, quantity: (2.0/4.0)},
                                       {ingredient: celery, quantity: (2.0/4.0)},
                                       {ingredient: bok_choy, quantity: (12.0/4.0)},
                                       {ingredient: red_curry_paste, quantity: (6.0/4.0)},
                                       {ingredient: pearled_barley, quantity: (72.0/4.0), include: false},
                                       {ingredient: can_coconut_milk, quantity: (2.0/4.0)},
                                       {ingredient: salmon_filet, quantity: (24.0/4.0)},
                                       {ingredient: rice_flour, quantity: (48.0/4.0), include: false}]

      cheese_ravioli_three_pepper = Recipe.create! name: "Cheese Ravioli with Three Pepper Topping",
      description: "Ravioli so good that everyone will ask for seconds.",
      prep_time: 15 + 5,
      published: true,
      photo: File.open(Rails.root.join('public', 'seed', 'recipes', 'cheese_ravioli_three_pepper.jpg')),
      preparation:"Ravioli
      1. Bring a large pot of lightly salted water to a boil. Cook ravioli in boiling water for 8 to 10 minutes, or until done; drain.
      2. Heat olive oil in large skillet over medium heat. Saute onion and bell peppers until tender.
      3. Add one cup of the broth, season with pepper flakes, and simmer 5 minutes.
      4. Stir in remaining broth, and cook until most of broth has evaporated. Spoon pepper mixture over ravioli.


      Parmigiano-Crumbed Zucchini
      1. Preheat grill pan over medium-high heat. Combine all ingredients in a bowl; toss well to coat.
      2. Arrange zucchini in a single layer in pan; grill 4 minutes, turning after 2 minutes.
      3. Chop 1 1/2 ounces ciabatta bread. Place bread and 1/2 teaspoon thyme in a food processor; pulse 10 times.
      4. Heat a skillet over medium-high heat. Add 2 teaspoons olive oil.
      5. Add bread mixture; cook 5 minutes, stirring frequently. Combine zucchini, bread mixture, and 2 tablespoons grated fresh Parmigiano-Reggiano.
      ",
      nutrition: "Ravioli
      Calories: 162
      Calories from Fat: 82
      Total Fat: 9.2g
      Saturated Fat: 2.1g
      Trans Fat: 0.0g
      Cholesterol: 11mg
      Sodium: 457mg
      Total Carbohydrates: 14.5g
      Dietary Fiber: 1.4g
      Sugars: 5.2g
      Protein: 5.6g

      Zucchini
      Calories: 130
      Fat: 8.3g
      Saturated fat: 1.6g
      Monounsaturated fat: 1.7g
      Polyunsaturated fat: 0.3g
      Protein: 1.2g
      Carbohydrate: 3.4g
      Fiber: 1.1g
      Cholesterol: 0.0mg
      Iron: 0.4mg
      Sodium: 371mg
      Calcium: 15mg"

      cheese_ravioli_three_pepper.portions.create   [{ingredient: cheese_ravioli, quantity: (1.5 / 4)},
                                       {ingredient: olive_oil, quantity: (3.0/4.0)}, #repeated
                                       {ingredient: onion, quantity: (1.0/4.0)},
                                       {ingredient: green_pepper, quantity: (1.0/4.0)},
                                       {ingredient: red_pepper, quantity: (1.0/4.0)},
                                       {ingredient: yellow_pepper, quantity: (1.0/4.0)},
                                       {ingredient: chicken_broth, quantity: (48.0/4.0)},

                                      #side dish: parmigiano-crumbed zucchini
                                       # {ingredient: olive_oil, quantity: (1.0/2.0)},
                                       {ingredient: sea_salt, quantity: (1.0/4.0)},
                                       {ingredient: zucchini, quantity: (2.0/4.0)}]

      lemon_chicken = Recipe.create! name: "Zesty Lemon Chicken",
      description: "Basic chicken dish.",
      prep_time: 15 + 5,
      published: true,
      photo: File.open(Rails.root.join('public', 'seed', 'recipes', 'crunchy_lemon_chicken.jpg')),
      preparation: "make some delicious chicken",
      nutrition: 'Lots!'

      # 48 ounces = 3 lbs.
      lemon_chicken.portions.create   [{ingredient: chicken, quantity: (48.0 / 4.0)},
                                       {ingredient: olive_oil, quantity: (3.0/4.0)}, #repeated
                                       {ingredient: garlic_clove, quantity: (1.0/4.0)},
                                       {ingredient: lemon, quantity: (1.0/4.0)},
                                       {ingredient: thyme, quantity: (2.0/4.0), include: false}]
    end

    desc 'add basic zip codes'
    task zipcodes: :environment do
      
        DeliveryZone.destroy_all
        Zipcode.destroy_all
        zone1 = DeliveryZone.create(name: '1')
        zone2 = DeliveryZone.create(name: '2')
        zone3 = DeliveryZone.create(name: '3')
        zone4 = DeliveryZone.create(name: '4')
        zone5 = DeliveryZone.create(name: '5')
        
        Zipcode.create! [{code: "19006", name: "East Norriton", delivery_zone: zone1},
                         {code: "19009", name: "East Norriton", delivery_zone: zone1},
                         {code: "19046", name: "East Norriton", delivery_zone: zone1},
                         {code: "18966", name: "East Norriton", delivery_zone: zone2},
                         {code: "19053", name: "East Norriton", delivery_zone: zone2},
                         {code: "18940", name: "East Norriton", delivery_zone: zone3},
                         {code: "18977", name: "East Norriton", delivery_zone: zone3},
                         {code: "18980", name: "East Norriton", delivery_zone: zone3},
                         {code: "19047", name: "East Norriton", delivery_zone: zone4},
                         {code: "19048", name: "East Norriton", delivery_zone: zone4},
                         {code: "19055", name: "East Norriton", delivery_zone: zone4},
                         {code: "19056", name: "East Norriton", delivery_zone: zone4},
                         {code: "19057", name: "East Norriton", delivery_zone: zone4},
                         {code: "19030", name: "East Norriton", delivery_zone: zone5},
                         {code: "19054", name: "East Norriton", delivery_zone: zone5},
                         {code: "19067", name: "East Norriton", delivery_zone: zone5}]

    end
  end
end
