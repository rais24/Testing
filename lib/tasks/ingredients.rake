namespace :ingredients do
  desc 'creates missing Billings from users in Stripe'
  task store_ingredients: :environment do
    # chicken breast family pack
    StoreIngredient.create!(name: "Boneless Chicken Breast", brand: "ShopRite", sku: "260993000009", amount: 3.0, unit: "lb")
    # StoreIngredient.create!(name: "Boneless Chicken Breast", brand: "ShopRite", sku: "260993000009", amount: 3.5, unit: "lb")
    # StoreIngredient.create!(name: "Boneless Chicken Breast", brand: "ShopRite", sku: "260993000009", amount: 4.0, unit: "lb")
    # StoreIngredient.create!(name: "Boneless Chicken Breast", brand: "ShopRite", sku: "260993000009", amount: 4.5, unit: "lb")
    # StoreIngredient.create!(name: "Boneless Chicken Breast", brand: "ShopRite", sku: "260993000009", amount: 5.0, unit: "lb")
    # StoreIngredient.create!(name: "Boneless Chicken Breast", brand: "ShopRite", sku: "260993000009", amount: 5.5, unit: "lb")
    # StoreIngredient.create!(name: "Boneless Chicken Breast", brand: "ShopRite", sku: "260993000009", amount: 6.0, unit: "lb")
    # StoreIngredient.create!(name: "Boneless Chicken Breast", brand: "ShopRite", sku: "260993000009", amount: 6.5, unit: "lb")
    # StoreIngredient.create!(name: "Boneless Chicken Breast", brand: "ShopRite", sku: "260993000009", amount: 7.0, unit: "lb")
    # StoreIngredient.create!(name: "Boneless Chicken Breast", brand: "ShopRite", sku: "260993000009", amount: 7.5, unit: "lb")

    # garlic
    StoreIngredient.create!(name: "Garlic", brand: "ShopRite", sku: "041190017645", amount: 1.0, unit: "unit")

    # lemons
    StoreIngredient.create!(name: "Lemon", brand: "", sku: "000000040532", amount: 1.0, unit: "unit")

    # oregeno leaves
    StoreIngredient.create!(name: "Oregeno Leaves", brand: "ShopRite", sku: "041190032129", amount: 1.0, unit: "unit")

    # fresh thyme
    StoreIngredient.create!(name: "Thyme Leaves", brand: "Goodness Gardens", sku: "021985200216", amount: 1.0, unit: "unit")

    # salt
    StoreIngredient.create!(name: "Salt - Iodized", brand: "ShopRite", sku: "041190001057", amount: 1.0, unit: "unit")

    # pepper
    StoreIngredient.create!(name: "Black Pepper - Pure Ground", brand: "ShopRite", sku: "041190032013", amount: 1.0, unit: "unit")


  end
  task add: :environment do

  end

  def ingredient_photo(name)
    begin
      File.open(Rails.root.join('public', 'seed', 'ingredients', name))
    rescue
      puts "Could not find file: #{name}"
      File.open(Rails.root.join('public', 'seed', 'ingredients', 'breadcrumbs.jpg'))
    end
  end

 end
