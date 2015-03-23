def ingredient_photo(name)
  begin
    File.open(Rails.root.join('public', 'seed', 'ingredients', name))
  rescue
    puts "Could not find file: #{name}"
    File.open(Rails.root.join('public', 'seed', 'ingredients', 'breadcrumbs.jpg'))
  end
end

def recipe_photo(name)
  begin
    File.open(Rails.root.join('public', 'seed', 'recipes', name))
  rescue
    puts "Could not find file: #{name}"
    File.open(Rails.root.join('public', 'seed', 'recipes', 'turkey_plum_sandwich.jpg'))
  end
end

arugula = Ingredient.create! name: "arugula", price: Money.new(100), unit: 'tsp', category: 'produce',
                            photo: ingredient_photo("arugula.jpg")

basil = Ingredient.create! name: "basil", price: Money.new(100), unit: 'tsp', category: 'produce',
                            photo: ingredient_photo("basil.jpg")
beef_broth = Ingredient.create! name: "beef broth", price: Money.new(100), unit: 'cup', category: 'groceries', pantry: true,
                            photo: ingredient_photo("beef_broth.jpg")
blue_cheese = Ingredient.create! name: "blue cheese", price: Money.new(100), unit: 'cup', category: 'produce',
                            photo: ingredient_photo("blue_cheese.jpg")
blueberries = Ingredient.create! name: "blueberries", price: Money.new(100), unit: 'cup', category: 'produce',
                            photo: ingredient_photo("blueberries.jpg")
broccoli = Ingredient.create! name: "broccoli", price: Money.new(100), unit: 'lb', category: 'produce',
                            photo: ingredient_photo("broccoli.jpg")
brown_rice = Ingredient.create! name: "brown rice", price: Money.new(100), unit: 'cup', category: 'produce',
                            photo: ingredient_photo("brown_rice.jpg")
brown_sugar = Ingredient.create! name: "brown sugar", price: Money.new(100), unit: 'tsp', category: 'produce',
                            photo: ingredient_photo("brown_sugar.jpg")
butter = Ingredient.create! name: "butter", price: Money.new(100), unit: 'oz', category: 'produce',
                            photo: ingredient_photo("butter.jpg")

cabbage = Ingredient.create! name: "cabbage", price: Money.new(100), unit: 'unit', category: 'produce',
                            photo: ingredient_photo("cabbage.jpg")
cantaloupe = Ingredient.create! name: "cantaloupe", price: Money.new(100), unit: 'unit', category: 'produce',
                            photo: ingredient_photo("cantaloupe.jpg")
carrot = Ingredient.create! name: "carrot", price: Money.new(100), unit: 'unit', category: 'produce',
                            photo: ingredient_photo('carrot.jpg')
cashews = Ingredient.create! name: "cashews", price: Money.new(100), unit: 'cup', category: 'produce',
                            photo: ingredient_photo("cashews.jpg")
cheese_ravioli = Ingredient.create! name: "cheese ravioli", price: Money.new(100), unit: 'cup', category: 'produce',
                            photo: ingredient_photo("cheese_ravioli.jpg")
chicken_breast = Ingredient.create! name: "chicken breast", price: Money.new(100), unit: 'lb', category: 'meats',
                            photo: ingredient_photo('chicken_breast.jpg')
chicken_broth = Ingredient.create! name: "chicken broth", price: Money.new(100), unit: 'oz', category: 'produce',
                            photo: ingredient_photo('chicken_broth.jpg')
chicken_stock = Ingredient.create! name: "chicken stock", price: Money.new(100), unit: 'oz', category: 'produce',
                            photo: ingredient_photo("chicken_stock.jpg")
chopped_parsley = Ingredient.create! name: "chopped parsley", price: Money.new(100), unit: 'tbs', category: 'groceries', pantry: true,
                            photo: ingredient_photo('chopped_parsley.jpg')
cilantro = Ingredient.create! name: "cilantro", price: Money.new(100), unit: 'tsp', category: 'produce',
                            photo: ingredient_photo("cilantro.jpg")
cooking_spray = Ingredient.create! name: "cooking spray", price: Money.new(100), unit: 'tsp', category: 'produce',
                            photo: ingredient_photo("cooking_spray.jpg")
crushed_tomatoes = Ingredient.create! name: "crushed tomatoes", price: Money.new(100), unit: 'oz', category: 'produce',
                            photo: ingredient_photo("crushed_tomatoes.jpg")
cubed_avocado = Ingredient.create! name: "cubed avocado", price: Money.new(100), unit: 'unit', category: 'produce',
                            photo: ingredient_photo("cubed_avocado.jpg")
cucumber = Ingredient.create! name: "cucumber", price: Money.new(100), unit: 'unit', category: 'produce',
                            photo: ingredient_photo("cucumber.jpg")
diced_ham = Ingredient.create! name: "diced ham", price: Money.new(100), unit: 'cup', category: 'produce',
                            photo: ingredient_photo("diced_ham.jpg")
dijon_mustard = Ingredient.create! name: "dijon mustard", price: Money.new(100), unit: 'tsp', category: 'produce',
                            photo: ingredient_photo("dijon_mustard.jpg")
dried_oregano = Ingredient.create! name: "dried oregano", price: Money.new(100), unit: 'tsp', category: 'produce',
                            photo: ingredient_photo("dried_oregano.jpg")
dry_white_wine = Ingredient.create! name: "dry white_wine", price: Money.new(100), unit: 'cup', category: 'produce',
                            photo: ingredient_photo("dry_white_wine.jpg")
egg = Ingredient.create! name: "egg", price: Money.new(100), unit: 'unit', category: 'produce',
                            photo: ingredient_photo('egg.jpg')
focaccia = Ingredient.create! name: "focaccia", price: Money.new(100), unit: 'unit', category: 'produce',
                            photo: ingredient_photo("focaccia.jpg")
garlic_clove = Ingredient.create! name: "garlic clove", price: Money.new(100), unit: 'cup', category: 'produce',
                            photo: ingredient_photo("garlic_clove.jpg")
grated_carrots = Ingredient.create! name: "grated carrots", price: Money.new(100), unit: 'cup', category: 'produce',
                            photo: ingredient_photo("grated_carrots.jpg")
green_beans = Ingredient.create! name: "green beans", price: Money.new(100), unit: 'cup', category: 'produce',
                            photo: ingredient_photo("green_beans.jpg")
green_pepper = Ingredient.create! name: "green pepper", price: Money.new(100), unit: 'unit', category: 'produce',
                            photo: ingredient_photo('green_pepper.jpg')
ground_red_pepper_flakes = Ingredient.create! name: "ground red pepper flakes", price: Money.new(100), unit: 'cup', category: 'produce',
                            photo: ingredient_photo("ground_red_pepper.jpg")

honey = Ingredient.create! name: "honey", price: Money.new(100), unit: 'tsp', category: 'produce',
                            photo: ingredient_photo("honey.jpg")
honeydew = Ingredient.create! name: "honeydew", price: Money.new(100), unit: 'unit', category: 'produce',
                            photo: ingredient_photo("honeydew.jpg")

jamaican_jerk_seasoning = Ingredient.create! name: "jamaican jerk seasoning", price: Money.new(100), unit: 'tsp', category: 'produce',
                            photo: ingredient_photo("jamaican_jerk_seasoning.jpg")
jarred_pepperoncini = Ingredient.create! name: "jarred_pepperoncini", price: Money.new(100), unit: 'unit', category: 'produce',
                            photo: ingredient_photo("jarred_pepperoncini.jpg")

lemon = Ingredient.create! name: "lemon", price: Money.new(100), unit: 'unit', category: 'produce',
                            photo: ingredient_photo("lemon.jpg")
lime = Ingredient.create! name: "lime", price: Money.new(100), unit: 'unit', category: 'produce',
                            photo: ingredient_photo("lime.jpg")
lime_juice = Ingredient.create! name: "lime juice", price: Money.new(100), unit: 'tsp', category: 'produce',
                            photo: ingredient_photo("lime_juice.jpg")
mayonnaise = Ingredient.create! name: "mayonnaise", price: Money.new(100), unit: 'tsp', category: 'produce',
                            photo: ingredient_photo("mayonnaise.jpg")
minced_garlic = Ingredient.create! name: "minced garlic", price: Money.new(100), unit: :clove, category: 'produce',
                            photo: ingredient_photo('minced_garlic.jpg')
mint = Ingredient.create! name: "mint", price: Money.new(100), unit: 'cup', category: 'produce',
                            photo: ingredient_photo("mint.jpg")
mixed_salad_greens = Ingredient.create! name: "mixed salad greens", price: Money.new(100), unit: 'oz', category: 'produce',
                            photo: ingredient_photo("mixed_salad_greens.jpg")
mustard = Ingredient.create! name: "mustard", price: Money.new(100), unit: 'tsp', category: 'produce',
                            photo: ingredient_photo("mustard.jpg")
olive_oil = Ingredient.create! name: "olive oil", price: Money.new(100), unit: 'tbs', category: 'groceries', pantry: true,
                            photo: ingredient_photo('olive_oil.jpg')
onion = Ingredient.create! name: "onion", price: Money.new(100), unit: 'unit', category: 'produce',
                            photo: ingredient_photo("onion.jpg")
packaged_mushrooms = Ingredient.create! name: "packaged mushrooms", price: Money.new(100), unit: 'cup', category: 'produce',
                            photo: ingredient_photo("packaged_mushrooms.jpg")
packaged_tomatoes = Ingredient.create! name: "packaged tomatoes", price: Money.new(100), unit: 'cup', category: 'produce',
                            photo: ingredient_photo("packaged_tomatoes.jpg")
panko_crumbs = Ingredient.create! name: "panko crumbs", price: Money.new(100), unit: 'cup', category: 'produce',
                            photo: ingredient_photo("panko_crumbs.jpg")
paprika = Ingredient.create! name: "paprika", price: Money.new(100), unit: 'tsp', category: 'groceries', pantry: true,
                            photo: ingredient_photo('paprika.jpg')
parmesan_cheese = Ingredient.create! name: "parmesan cheese", price: Money.new(100), unit: 'tbs', category: 'groceries', pantry: true,
                            photo: ingredient_photo('parmesan_cheese.jpg')
parsley = Ingredient.create! name: "parsley", price: Money.new(100), unit: 'tsp', category: 'produce',
                            photo: ingredient_photo("parsley.jpg")
peanut_oil = Ingredient.create! name: "peanut oil", price: Money.new(100), unit: 'tsp', category: 'produce',
                            photo: ingredient_photo("peanut_oil.jpg")
pepper = Ingredient.create! name: "pepper", price: Money.new(100), unit: 'tsp', category: 'groceries', pantry: true,
                            photo: ingredient_photo('pepper.jpg')
pork_chop = Ingredient.create! name: "pork chop", price: Money.new(100), unit: 'lb', category: 'produce',
                            photo: ingredient_photo("pork_chop.jpg")
pork_tenderloin = Ingredient.create! name: "pork tenderloin", price: Money.new(100), unit: 'lb', category: 'meats',
                            photo: ingredient_photo("pork_tenderloin.jpg")
radish = Ingredient.create! name: "radish", price: Money.new(100), unit: 'cup', category: 'produce',
                            photo: ingredient_photo("radish.jpg")
red_pepper = Ingredient.create! name: "red pepper", price: Money.new(100), unit: 'unit', category: 'produce',
                            photo: ingredient_photo('red_pepper.jpg')

salmon_filet = Ingredient.create! name: "salmon filet", price: Money.new(100), unit: 'lb', category: 'produce',
                            photo: ingredient_photo("salmon_filet.jpg")
salsa = Ingredient.create! name: "salsa", price: Money.new(100), unit: 'tsp', category: 'produce',
                            photo: ingredient_photo("salsa.jpg")
salt = Ingredient.create! name: "salt", price: Money.new(100), unit: 'tsp', category: 'groceries', pantry: true,
                            photo: ingredient_photo('salt.jpg')
sea_salt = Ingredient.create! name: "sea salt", price: Money.new(100), unit: 'tsp', category: 'produce',
                            photo: ingredient_photo("sea_salt.jpg")
sesame_seeds = Ingredient.create! name: "sesame seeds", price: Money.new(100), unit: 'cup', category: 'produce',
                            photo: ingredient_photo("sesame_seeds.jpg")
sliced_red_onion = Ingredient.create! name: "sliced red onion", price: Money.new(100), unit: 'cup', category: 'produce',
                            photo: ingredient_photo("sliced_red_onion.jpg")
shiitake_mushrooms = Ingredient.create! name: "shiitake mushrooms", price: Money.new(100), unit: 'cup', category: 'produce',
                            photo: ingredient_photo("shiitake_mushrooms.jpg")
sirloin_steak = Ingredient.create! name: "sirloin steak", price: Money.new(100), unit: 'lb', category: 'produce',
                            photo: ingredient_photo("sirloin_steak.jpg")
soy_sauce = Ingredient.create! name: "soy sauce", price: Money.new(100), unit: 'tsp', category: 'produce',
                            photo: ingredient_photo("soy_sauce.jpg")
spinach_leaves = Ingredient.create! name: "spinach leaves", price: Money.new(100), unit: 'cup', category: 'produce',
                            photo: ingredient_photo("spinach_leaves.jpg")
sugar = Ingredient.create! name: "sugar", price: Money.new(100), unit: 'tsp', category: 'produce',
                            photo: ingredient_photo("sugar.jpg")

tamari_sauce = Ingredient.create! name: "tamari sauce", price: Money.new(100), unit: 'tsp', category: 'produce',
                            photo: ingredient_photo("tamari_sauce.jpg")
thyme = Ingredient.create! name: "thyme", price: Money.new(100), unit: 'tsp', category: 'produce',
                            photo: ingredient_photo("thyme.jpg")
toased_walnuts = Ingredient.create! name: "toased walnuts", price: Money.new(100), unit: 'cup', category: 'produce',
                            photo: ingredient_photo("toasted_walnuts.jpg")
tomato = Ingredient.create! name: "tomato", price: 1.25, unit: 'unit', category: 'produce',
                            photo: ingredient_photo("tomato.jpg")
vegetable_oil = Ingredient.create! name: "vegetable oil", price: Money.new(100), unit: 'cup', category: 'produce',
                            photo: ingredient_photo("vegetable_oil.jpg")
vinaigrette = Ingredient.create! name: "vinaigrette", price: Money.new(100), unit: 'cup', category: 'produce',
                            photo: ingredient_photo("vinaigrette.jpg")

white_vinegar = Ingredient.create! name: "white vinegar", price: Money.new(100), unit: 'cup', category: 'produce',
                            photo: ingredient_photo("white_vinegar.jpg")

yellow_pepper = Ingredient.create! name: "yellow pepper", price: Money.new(100), unit: 'unit', category: 'produce',
                            photo: ingredient_photo('yellow_pepper.jpg')
yogurt = Ingredient.create! name: "yogurt", price: Money.new(100), unit: 'cup', category: 'produce',
                            photo: ingredient_photo("yogurt.jpg")

zucchini = Ingredient.create! name: "zucchini", price: Money.new(100), unit: 'unit', category: 'produce',
                            photo: ingredient_photo("zucchini.jpg")

mexicali_chicken = Recipe.create! name: "Mexicali Chicken",
description: "This is a must-taste for all you chicken lovers.",
prep_time: 15 + 3,
published: true,
photo: recipe_photo('mexicali_chicken.jpg'),
preparation:"Chicken
1. Spread mustard over one side of chicken breasts. Heat oil in a large nonstick skillet over medium-high heat until hot. Add chicken breasts, with mustard side down; cook 4 minutes. Turn chicken over. Reduce heat to medium.
2. Combine salsa and lime juice; spoon over and around chicken. Simmer uncovered until chicken is cooked through and sauce thickens, 6-8 minutes.
3. Transfer chicken to serving plates. Cook the remaining pan juices in skillet over high heat until slightly reduced, about 30 seconds.
4. Spoon juices over the chicken; top with avocado. Garnish with green onions, if desired.

Rice
1. Cook rice according to package directions, omitting fat. Stir in juice and salt. Sprinkle with seeds.
",
nutrition:"Chicken
Calories: 177
Fat: 7g
Saturated fat: 1g
Monounsaturated fat: 4g
Polyunsaturated fat: 1g
Protein: 24g
Carbohydrate: 4g
Fiber: 1g
Cholesterol: 63mg
Iron: 1mg
Sodium: 345mg
Calcium: 28mg

Rice
Calories: 187
Fat: 2.5g
Saturated fat: 0.4g
Monounsaturated fat: 0.9g
Polyunsaturated fat: 1g
Protein: 4.4g
Carbohydrate: 36.7g
Fiber: 3.1g
Cholesterol: 0.0mg
Iron: 1mg
Sodium: 153mg
Calcium: 39mg"

crispy_salmon = Recipe.create! name: "Crispy Salmon",
description: "Who knew that eating healthy could taste so good?",
prep_time: 15 + 5,
published: true,
photo: recipe_photo('crispy_salmon.jpg'),
preparation:"Salmon
1. Combine first 5 ingredients in a large bowl. Cover and refrigerate.
2. Combine juice, oil, 1/4 teaspoon salt, 1/4 teaspoon pepper, and garlic, stirring with a whisk.
3. Heat a large nonstick skillet coated with cooking spray over medium heat. Sprinkle salmon with 1/4 teaspoon salt and 1/4 teaspoon pepper. Add fish to pan; cook 9 minutes or until fish flakes easily when tested with a fork, turning once. Combine arugula mixture and juice mixture; toss well to coat. Place 1/2 cup herb salad on each of 6 plates; top each serving with 1 fillet. Serve with lemon wedges.

Shiitake Slaw
1. Heat the oil in large skillet over high heat.
2. Add the mushrooms and stir-fry 1 minute.
3. Add the garlic and cabbage and stir-fry for 2 to 3 minutes more.
4. Stir in the soy sauce, black pepper, lime juice and the toasted sesame seeds.
5. Transfer to a serving bowl and serve.
",
nutrition:"Salmon
Calories: 303
Calories from fat: 49%
Fat: 16.4g
Saturated fat: 2.8g
Monounsaturated fat: 8.4g
Polyunsaturated fat: 3.3g
Protein: 35.4g
Carbohydrate: 1.4g
Fiber: 0.6g
Cholesterol: 111mg
Iron: 1.4mg
Sodium: 286mg
Calcium: 35mg

Shiitake Slaw
Calories: 566
Fat: 43.5g
Saturated fat: 3.0g
Carbohydrates: 37.1g
Sugar: 17.1g
Protein: 17.9g
Cholesterol: 0.0mg
Sodium: 3,091.5mg
Dietary fiber: 11.7g
"

steak_pizzaiola = Recipe.create! name: "Steak Pizzaiola",
description: "A family favorite, from ours to yours.",
prep_time: 20 + 3,
published: true,
photo: recipe_photo('steak_pizzaiola.jpg'),
preparation:"Steak
1. Sprinkle the steak all over with 1/4 teaspoon salt.
2. Heat the olive oil in a large skillet over medium-high heat.
3. Add the steak and sear until browned, about 2 minutes per side. Transfer to a plate.
4. Add the garlic to the skillet.
5. Once it sizzles, add the onion and bell peppers and cook, stirring occasionally, until they soften slightly, about 4 minutes.
6. Add the pepperoncini, tomatoes, oregano, red pepper flakes and 3/4 cup water and stir to combine.
7. Bring to a rapid simmer, then nestle the steak in the sauce and simmer, turning once, until medium rare, about 7 minutes.
8. Transfer the steak to a cutting board and let rest about 5 minutes. Continue simmering the sauce until thickened, about 3 more minutes.
9. Thinly slice the steak against the grain and divide among plates. Top with the sauce and parsley. Serve with focaccia.

Green beans
1. Trim stem end from beans. Arrange beans in a steamer basket over boiling water; cover and steam 10 minutes.
2. Combine tomato and next 3 ingredients in a large saucepan. Cook, uncovered, over medium heat 3 minutes, stirring often.
3. Stir in beans, parsley, thyme, and pepper. Cover and cook over low heat 10 minutes or until beans are tender.
",
nutrition:"Steak
Calories: 340
Calories: from Fat 122
Total Fat: 13.5g
Saturated Fat: 3.5g
Cholesterol: 69mg
Sodium: 608mg
Total Carbohydrates: 19.7g
Dietary Fiber: 5.6g
Sugars: 11.0g
Protein: 35.5g

Green Beans
Calories: 74
Calories from fat: 0.0%
Fat: 1.1g
Saturated fat: 0.3g
Monounsaturated fat: 0.0g
Polyunsaturated fat: 0.0g
Protein: 5.4g
Carbohydrate: 12.8g
Fiber: 3.4g
Cholesterol: 7mg
Iron: 0.0mg
Sodium: 126mg
Calcium: 0.0mg"

pork_chops_provencal = Recipe.create! name: "Pork Chops Provencal",
description: "Here's a new spin on a classic dish",
prep_time: 15 + 6,
published: true,
photo: recipe_photo('pork_chops_provencal.jpg'),
preparation:"Pork Chop
1. Heat oil in a large skillet (12 or 15 inches) and brown chops on both sides over moderate heat, about 15 minutes. Remove chops. If necessary, prepare chops in 2 batches.
2. Add mushrooms to skillet and saute until lightly browned. Add wine and stir to loosen all brown bits from bottom. Empty mushrooms and wine into a bowl and mix with tomatoes, onions, garlic, parsley and reduced chicken stock.
3. Return all chops to skillet (making 2 layers, if necessary) and pour mixture in bowl over them. Season very lightly with salt and pepper, cover skillet securely and cook over very low heat about 2 hours, or until meat is almost but not quite falling off the bone.
4. Remove chops to serving platter and keep warm. Raise heat under skillet and boil contents hard, stirring constantly, until the mixture has a viscous, saucelike consistency. Pour over chops and serve.

Garlic Sauteed Spinach
1. Rinse the spinach well in cold water to make sure it's very clean. Spin it dry in a salad spinner, leaving just a little water clinging to the leaves.
2. In a very large pot or Dutch oven, heat the olive oil and saute the garlic over medium heat for about 1 minute, but not until it's browned.
3. Add all the spinach, the salt, and pepper to the pot, toss it with the garlic and oil, cover the pot, and cook it for 2 minutes.
4. Uncover the pot, turn the heat on high, and cook the spinach for another minute, stirring with a wooden spoon, until all the spinach is wilted.
5. Using a slotted spoon, lift the spinach to a serving bowl and top with the butter, a squeeze of lemon, and a sprinkling of salt. Serve hot.
",
nutrition:"Pork Chops
Total Calories: 1,276
Calories from Fat: 839
Total Fat: 93.2g
Saturated Fat: 33.0g
Cholesterol: 293mg
Sodium: 870mg
Total Carbohydrates: 16.4g
Dietary Fiber: 4.3g
Sugars: 8.9g
Protein: 85.2g

Garlic Sauteed Spinach
Calories: 132
Calories from Fat: 95
Total Fat: 10.6g
Saturated Fat: 2.9g
Cholesterol: 8mg
Sodium: 1318mg
Total Carbohydrates: 7.8g
Dietary Fiber: 3.9g
Sugars: 0.8g
Protein: 5.2g
"

crunchy_lemon_chicken = Recipe.create! name: "Crunchy Lemon Chicken",
description: "Everyone will enjoy eating this tasty fun dish.",
prep_time: 15 + 10,
published: true,
photo: recipe_photo('crunchy_lemon_chicken.jpg'),
preparation:"Chicken
1. Preheat oven to 450ºF. Fit a wire rack into a rimmed baking sheet.
2. In a bowl, mix yogurt, parsley, garlic, lemon zest and juice, and a pinch of salt and pepper. Transfer half to a dish, add chicken and turn to coat. Set aside remaining yogurt mixture.
3. Combine panko, Parmesan and paprika. Dredge chicken in panko mixture. Transfer to rack in baking sheet. Mist chicken with cooking spray; sprinkle with salt and pepper.
4. Bake chicken until golden brown and cooked through, about 15 minutes. Stir cucumber and radishes into reserved yogurt mixture and serve with chicken.


Broccoli w/ Cashews
1. Place the broccoli into a large pot with about 1 inch of water in the bottom. Bring to a boil, and cook for 7 minutes, or until tender but still crisp. Drain, and arrange broccoli on a serving platter.
2. While the broccoli is cooking, melt the butter in a small skillet over medium heat. Mix in the brown sugar, soy sauce, vinegar, pepper and garlic. Bring to a boil, then remove from the heat. Mix in the cashews, and pour the sauce over the broccoli. Serve immediately.
",
nutrition:"Chicken
Calories: 279
Fat: 5.9g
Saturated fat: 2g
Monounsaturated fat: 1.5g
Polyunsaturated fat: 0.6g
Protein: 33g
Carbohydrate: 24g
Fiber: 3g
Cholesterol: 80mg
Iron: 2mg
Sodium: 410mg
Calcium: 187mg

Broccoli w/ Cashews
Calories: 185
Calories from Fat: 128
Total Fat: 14.2g
Saturated Fat: 7.2g
Trans Fat: 0.0g
Cholesterol: 27mg
Sodium: 563mg
Total Carbohydrates: 12.5g
Dietary Fiber: 3.3g
Sugars: 3.9g
Protein: 5.0g
"

turkey_plum_sandwich = Recipe.create! name: "Grilled Turkey-Plum Sandwiches",
description: "These turkey sandwiches are healthy, fresh, and delicious. What more could we ask for?",
prep_time: 12 + 10,
published: true,
photo: recipe_photo('turkey_plum_sandwich.jpg'),
preparation:"Turkey Sandwich
1. Combine first 3 ingredients in a small bowl; stir well. Set mixture aside.
2. Heat a grill pan over medium-high heat. Place 4 bread slices in a single layer on grill pan; grill 3 minutes on one side or until grill marks appear. Remove bread from grill pan. Repeat procedure with remaining bread.
3. Coat grill pan with cooking spray. Sprinkle turkey evenly with salt. Add turkey to pan; grill 3 minutes or until done, turning after 1 1/2 minutes.
4. Spread 2 teaspoons mayonnaise mixture over untoasted side of each of 4 bread slices; top each serving with about 2 1/4 ounces turkey. Divide plum slices evenly among sandwiches; top each serving with 4 basil leaves. Top sandwiches with remaining 4 bread slices.


Tangy Mustard Coleslaw
1. Combine cabbage, onion, and 1 cup carrot in a large bowl. Combine white wine vinegar, sugar, mustard, mayonnaise, salt, black pepper, and red pepper in a small bowl; stir well with a whisk.
2. Add the mustard mixture to cabbage mixture, and toss well to coat. Cover and chill for 20 minutes. Stir before serving.
",
nutrition:"Turkey Sandwich
Calories: 292
Fat: 6.1g
Saturated fat: 0.7g
Monounsaturated fat: 2.1g
Polyunsaturated fat: 2.2g
Protein: 28.9g
Carbohydrate: 28.7g
Fiber: 4.7g
Cholesterol: 53mg
Iron: 2.6mg
Sodium: 631mg
Calcium: 74mg

Tangy Mustard Coleslaw
Calories: 58
Calories from fat: 12%
Fat: 0.8g
Saturated fat: 0.1g
Monounsaturated fat: 0.1g
Polyunsaturated fat: 0.3g
Protein: 1.5g
Carbohydrate: 12.3g
Fiber: 3g
Cholesterol: 0.0mg
Iron: 0.5mg
Sodium: 172mg
Calcium: 43mg"

cheese_ravioli_three_pepper = Recipe.create! name: "Cheese Ravioli with Three Pepper Topping",
description: "Ravioli so good that everyone will ask for seconds.",
prep_time: 15 + 5,
published: true,
photo: recipe_photo('cheese_ravioli_three_pepper.jpg'),
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

jamaican_pork_melon = Recipe.create! name: "Jamaican Pork With Melon",
description: "Looking for something new? We've got this for you...",
prep_time: 15 + 5,
published: true,
photo: recipe_photo('jamaican_pork_melon.jpg'),
preparation:"Pork
1. Toss pork cubes and onion with oil and jerk seasoning in a medium mixing bowl until evenly coated.
2. Thread eight 12-inch skewers alternately with pork, onion, honeydew, and cantaloupe pieces.
3. Place pork skewers on the lightly oiled of the grill directly over medium heat.
4. Grill for 18 to 24 minutes or until pork is cooked through and no pink remains. Remove from grill; brush with honey. Makes 4 servings.


Salad
1. Toss together first 4 ingredients; drizzle with desired amount of vinaigrette, tossing gently to coat.
",
nutrition:"Pork
Calories: 210
Calories from Fat: 99
Total Fat: 11.0g
Saturated Fat: 2.5g
Trans Fat: 0.0g
Cholesterol: 75mg
Sodium: 128mg
Total Carbohydrates: 5.1g
Sugars: 5.1g
Protein: 24.2g

Salad
Calories: 129
Calories from Fat: 59
Total Fat: 6.6g
Saturated Fat: 2.3g
Cholesterol: 8mg
Sodium: 206mg
Total Carbohydrates: 13.7g
Dietary Fiber: 1.5g
Sugars: 4.9g
Protein: 6.3g
"


mexicali_chicken.portions.create [{ingredient: dijon_mustard, quantity: (1/4)},
                                 {ingredient: chicken_breast, quantity: (1/4)},
                                 {ingredient: olive_oil, quantity: (1.0/2.0)},
                                 {ingredient: salsa, quantity: (1.0/8.0)},
                                 {ingredient: lime_juice, quantity: (1.0/1.0)}, #repeated
                                 {ingredient: cubed_avocado, quantity: (1.0/16.0)},

                                #side dish: brown rice w/ sesame
                                 {ingredient: brown_rice, quantity: (1.0/4.0)},
                                 # {ingredient: lime_juice, quantity: (1.0/2.0)},
                                 {ingredient: salt, quantity: (1.0/16.0)},
                                 {ingredient: sesame_seeds, quantity: (1.0/4.0)}]


crispy_salmon.portions.create   [{ingredient: arugula, quantity: (1.0/4.0)},
                                 {ingredient: parsley, quantity: (1.0/8.0)},
                                 {ingredient: cilantro, quantity: (1.0/12.0)},
                                 {ingredient: basil, quantity: (1.0/12.0)},
                                 {ingredient: mint, quantity: (1.0/24.0)},
                                 {ingredient: olive_oil, quantity: (1.0/6.0)},
                                 {ingredient: salt, quantity: (1.0/12.0)},
                                 {ingredient: pepper, quantity: (1.0/12.0)},
                                 {ingredient: garlic_clove, quantity: (7.0/6.0)}, #repeated
                                 {ingredient: cooking_spray, quantity: (1.0/32.0)},
                                 {ingredient: salmon_filet, quantity: (6.0/6.0)},
                                 {ingredient: lemon, quantity: (1.0/6.0)},

                                #side dish: warm shiitake slaw
                                 {ingredient: vegetable_oil, quantity: (3.0/4.0)},
                                 {ingredient: shiitake_mushrooms, quantity: (1.0/8.0)},
                                 # {ingredient: garlic_clove, quantity: (1.0)},
                                 {ingredient: cabbage, quantity: (3.0/16.0)},
                                 {ingredient: tamari_sauce, quantity: (3.0/4.0)},
                                 # {ingredient: pepper, quantity: (1.0/32.0)},
                                 {ingredient: lime, quantity: (1.0/4.0)},
                                 {ingredient: sesame_seeds, quantity: (1.0/4.0)}]



steak_pizzaiola.portions.create  [{ingredient: sirloin_steak, quantity: (5/16)},
                                 {ingredient: olive_oil, quantity: (1.0/2.0)},
                                 {ingredient: garlic_clove, quantity: (1.0)},
                                 {ingredient: onion, quantity: (1.0/4)},

                                 {ingredient: green_pepper, quantity: (1.0/2.0)},
                                 {ingredient: jarred_pepperoncini, quantity: (1.0)},
                                 {ingredient: crushed_tomatoes, quantity: (1.0/4.0)},
                                 {ingredient: dried_oregano, quantity: (1.0/8.0)},
                                 {ingredient: ground_red_pepper_flakes, quantity: (1.0/32.0)},
                                 {ingredient: parsley, quantity: (5.0/8.0)}, #repeated
                                 {ingredient: focaccia, quantity: (1.0/1.0)},

                                #side dish: green beans
                                 {ingredient: green_beans, quantity: (1.0/4.0)},
                                 {ingredient: tomato, quantity: (1.0/2.0)},
                                 {ingredient: beef_broth, quantity: (1.0/12.0)},
                                 {ingredient: minced_garlic, quantity: (1.0/4.0)},
                                 {ingredient: diced_ham, quantity: (1.0/2.0)},
                                 # {ingredient: parsley, quantity: (1.0/2.0)},
                                 {ingredient: thyme, quantity: (1.0/4.0)},
                                 {ingredient: pepper, quantity: (1.0/16.0)}]


pork_chops_provencal.portions.create [{ingredient: olive_oil, quantity: (1.0/1.0)}, #repeated
                                     {ingredient: pork_chop, quantity: (3.0/4.0)},
                                     {ingredient: packaged_mushrooms, quantity: (1.0/4.0)},
                                     {ingredient: dry_white_wine, quantity: (1.0/8.0)},
                                     {ingredient: packaged_tomatoes, quantity: (1.0/4.0)},
                                     {ingredient: onion, quantity: (1.0/2.0)},
                                     {ingredient: garlic_clove, quantity: (9.0/4.0)}, #repeated
                                     {ingredient: chopped_parsley, quantity: (1.0/8.0)},
                                     {ingredient: chicken_stock, quantity: (1.0/8.0)},
                                     {ingredient: salt, quantity: (1.0/2.0)}, #repeated
                                     {ingredient: pepper, quantity: (3.0/16.0)}, #repeated

                                    #side dish: garlic sauteed spinach
                                     {ingredient: spinach_leaves, quantity: (3.0/8.0)}, #lbs
                                     # {ingredient: olive_oil, quantity: (1.0/2.0)},
                                     # {ingredient: garlic_clove, quantity: (3.0/2.0)},
                                     # {ingredient: salt, quantity: (1.0/2.0)},
                                     # {ingredient: pepper, quantity: (3.0/16.0)},
                                     {ingredient: butter, quantity: (1.0/4.0)},
                                     {ingredient: lemon, quantity: (1.0/4.0)}]


crunchy_lemon_chicken.portions.create   [{ingredient: yogurt, quantity: (1.0/4.0)},
                                         {ingredient: parsley, quantity: (1.0/16.0)},
                                         {ingredient: garlic_clove, quantity: (7.0/12.0)}, #repeated
                                         {ingredient: lemon, quantity: (1.0/2.0)},
                                         {ingredient: salt, quantity: (1.0/32.0)},
                                         {ingredient: pepper, quantity: (1.0/32.0)},
                                         {ingredient: chicken_breast, quantity: (1.0)},
                                         {ingredient: panko_crumbs, quantity: (1.0/4.0)},
                                         {ingredient: parmesan_cheese, quantity: (3.0/4.0)},
                                         {ingredient: paprika, quantity: (1.0/8.0)},
                                         {ingredient: cucumber, quantity: (1.0/4.0)},
                                         {ingredient: radish, quantity: (3.0)},

                                        #side dish: broccoli with garlic butter and cashews
                                         {ingredient: broccoli, quantity: (3.0/12.0)},
                                         {ingredient: butter, quantity: (1.0/18.0)},
                                         {ingredient: brown_sugar, quantity: (1.0/6.0)},
                                         {ingredient: soy_sauce, quantity: (3.0/6.0)},
                                         {ingredient: white_vinegar, quantity: (1.0/3.0)},
                                         # {ingredient: pepper, quantity: (1.0/24.0)},
                                         # {ingredient: garlic_clove, quantity: (1.0/3.0)},
                                         {ingredient: cashews, quantity: (1.0/18.0)}]


turkey_plum_sandwich.portions.create   [{ingredient: cabbage, quantity: (5.0/14.0)}, #repeated
                                         {ingredient: sliced_red_onion, quantity: (1.0/7.0)},
                                         {ingredient: grated_carrots, quantity: (1.0/7.0)},
                                         {ingredient: white_vinegar, quantity: (1.0/28.0)},
                                         {ingredient: sugar, quantity: (2.0/7.0)},
                                         {ingredient: mustard, quantity: (2.0/7.0)},
                                         {ingredient: mayonnaise, quantity: (2/7.0)},
                                         {ingredient: salt, quantity: (1.0/32.0)},
                                         {ingredient: pepper, quantity: (1.0/32.0)}, #repeated
                                         {ingredient: ground_red_pepper_flakes, quantity: (1.0/32.0)},

                                        #side dish: tangy mustard coleslaw
                                         {ingredient: vegetable_oil, quantity: (3.0/4.0)},
                                         {ingredient: shiitake_mushrooms, quantity: (1.0/8.0)},
                                         {ingredient: garlic_clove, quantity: (1.0)},
                                         # {ingredient: cabbage, quantity: (3.0/16.0)},
                                         {ingredient: tamari_sauce, quantity: (3.0/4.0)},
                                         # {ingredient: pepper, quantity: (1.0/32.0)},
                                         {ingredient: lime, quantity: (1.0/4.0)},
                                         {ingredient: sesame_seeds, quantity: (1.0/4.0)}]


cheese_ravioli_three_pepper.portions.create   [{ingredient: cheese_ravioli, quantity: (1.0/6.0)},
                                 {ingredient: olive_oil, quantity: (1.0/1.0)}, #repeated
                                 {ingredient: onion, quantity: (1.0/6.0)},
                                 {ingredient: green_pepper, quantity: (1.0/6.0)},
                                 {ingredient: red_pepper, quantity: (1.0/12.0)},
                                 {ingredient: yellow_pepper, quantity: (1.0/12.0)},
                                 {ingredient: chicken_broth, quantity: (1.0/3.0)},
                                 {ingredient: ground_red_pepper_flakes, quantity: (1.0/24.0)},

                                #side dish: parmigiano-crumbed zucchini
                                 # {ingredient: olive_oil, quantity: (1.0/2.0)},
                                 {ingredient: sea_salt, quantity: (1.0/16.0)},
                                 {ingredient: pepper, quantity: (1.0/16.0)},
                                 {ingredient: zucchini, quantity: (1.0/2.0)}]

jamaican_pork_melon.portions.create [{ingredient: pork_tenderloin, quantity: (3.0/8.0)},
                                 {ingredient: onion, quantity: (1.0/2.0)},
                                 {ingredient: peanut_oil, quantity: (1.0/2.0)},
                                 {ingredient: jamaican_jerk_seasoning, quantity: (1.0)},
                                 {ingredient: honeydew, quantity: (1.0/16.0)},
                                 {ingredient: cantaloupe, quantity: (1.0/8.0)},
                                 {ingredient: honey, quantity: (1.0/4.0)},

                                #side dish: berry delicious summer salad
                                 {ingredient: mixed_salad_greens, quantity: (1.0)},
                                 {ingredient: blueberries, quantity: (1.0/4.0)},
                                 {ingredient: blue_cheese, quantity: (1.0/16.0)},
                                 {ingredient: toased_walnuts, quantity: (1.0/32.0)},
                                 {ingredient: vinaigrette, quantity: (1.0/32.0)}]

# # Diets
Diet.create! [{name: :no_red_meat, description: "I don't eat red meat."},
              {name: :vegetarian, description: "I am vegetarian."},
              {name: :vegan, description: "I am vegan."},
              {name: :other, description: "I have other dietary restrictions."}]

# Allergies
Allergy.create! [{name: :nut, description: "meals containing nuts"},
                 {name: :wheat, description: "meals with wheat"},
                 {name: :seafood, description: "meals with fish or other seafood"},
                 {name: :shellfish, description: "meals containing shellfish"},
                 {name: :lactose, description:  "anything dairy based"},
                 {name: :other, description: "other"}]
# Zip Codes
Zipcode.create! [{code: "19114", name: "Peapod Philly"},
                 {code: "19116", name: "Peapod Philly"},
                 {code: "19154", name: "Peapod Philly"},
                 {code: "19001", name: "Abington"},
                 {code: "19002", name: "Ambler"},
                 {code: "19006", name: "Huntingdon Valley"},
                 {code: "19012", name: "Cheltenham"},
                 {code: "19025", name: "Dresher"},
                 {code: "19027", name: "Elkins Park"},
                 {code: "19031", name: "Flourtown"},
                 {code: "19034", name: "Fort Washington"},
                 {code: "19038", name: "Glenside"},
                 {code: "19040", name: "Hatboro"},
                 {code: "19044", name: "Horsham"},
                 {code: "19046", name: "Jenkintown"},
                 {code: "19075", name: "Oreland"},
                 {code: "19090", name: "Willow Grove"},
                 {code: "19095", name: "Wyncote"},
                 {code: "19422", name: "Blue Bell"},
                 {code: "19436", name: "Gwynedd"},
                 {code: "19454", name: "North Wales"},
                 {code: "19477", name: "Spring House"},
                 {code: "19085", name: "Villanova"},
                 {code: "19401", name: "Norristown"},
                 {code: "19403", name: "Norristown"},
                 {code: "19405", name: "Bridgeport"},
                 {code: "19406", name: "King Of Prussia"},
                 {code: "19428", name: "Conshohocken"},
                 {code: "19444", name: "Lafayette Hill"},
                 {code: "19462", name: "Plymouth Meeting"},
                 {code: "19003", name: "Ardmore"},
                 {code: "19004", name: "Bala Cynwyd"},
                 {code: "19008", name: "Broomall"},
                 {code: "19010", name: "Bryn Mawr"},
                 {code: "19035", name: "Gladwyne"},
                 {code: "19041", name: "Haverford"},
                 {code: "19066", name: "Merion Station"},
                 {code: "19072", name: "Narberth"},
                 {code: "19083", name: "Havertown"},
                 {code: "19096", name: "Wynnewood"},
                 {code: "19013", name: "Chester"},
                 {code: "19015", name: "Brookhaven"},
                 {code: "19018", name: "Clifton Heights"},
                 {code: "19022", name: "Crum Lynne"},
                 {code: "19023", name: "Darby"},
                 {code: "19026", name: "Drexel Hill"},
                 {code: "19029", name: "Essington"},
                 {code: "19032", name: "Folcroft"},
                 {code: "19033", name: "Folsom"},
                 {code: "19036", name: "Glenolden"},
                 {code: "19043", name: "Holmes"},
                 {code: "19050", name: "Lansdowne"},
                 {code: "19064", name: "Springfield"},
                 {code: "19070", name: "Morton"},
                 {code: "19074", name: "Norwood"},
                 {code: "19076", name: "Prospect Park"},
                 {code: "19078", name: "Ridley Park"},
                 {code: "19079", name: "Sharon Hill"},
                 {code: "19081", name: "Swarthmore"},
                 {code: "19082", name: "Upper Darby"},
                 {code: "19086", name: "Wallingford"},
                 {code: "19094", name: "Woodlyn"},
                 {code: "19014", name: "Aston"},
                 {code: "19061", name: "Marcus Hook"},
                 {code: "19063", name: "Media"},
                 {code: "19073", name: "Newtown Square"},
                 {code: "19317", name: "Chadds Ford"},
                 {code: "19319", name: "Cheyney"},
                 {code: "19342", name: "Glen Mills"},
                 {code: "19373", name: "Thornton"},
                 {code: "19092", name: "Shoprite Philadelphia"},
                 {code: "19093", name: "Shoprite Philadelphia"},
                 {code: "19099", name: "Shoprite Philadelphia"},
                 {code: "19101", name: "Shoprite Philadelphia"},
                 {code: "19102", name: "Shoprite Philadelphia"},
                 {code: "19103", name: "Shoprite Philadelphia"},
                 {code: "19104", name: "Shoprite Philadelphia"},
                 {code: "19105", name: "Shoprite Philadelphia"},
                 {code: "19106", name: "Shoprite Philadelphia"},
                 {code: "19107", name: "Shoprite Philadelphia"},
                 {code: "19108", name: "Shoprite Philadelphia"},
                 {code: "19109", name: "Shoprite Philadelphia"},
                 {code: "19110", name: "Shoprite Philadelphia"},
                 {code: "19111", name: "Shoprite Philadelphia"},
                 {code: "19112", name: "Shoprite Philadelphia"},
                 {code: "19115", name: "Shoprite Philadelphia"},
                 {code: "19118", name: "Shoprite Philadelphia"},
                 {code: "19119", name: "Shoprite Philadelphia"},
                 {code: "19120", name: "Shoprite Philadelphia"},
                 {code: "19121", name: "Shoprite Philadelphia"},
                 {code: "19122", name: "Shoprite Philadelphia"},
                 {code: "19123", name: "Shoprite Philadelphia"},
                 {code: "19124", name: "Shoprite Philadelphia"},
                 {code: "19125", name: "Shoprite Philadelphia"},
                 {code: "19126", name: "Shoprite Philadelphia"},
                 {code: "19127", name: "Shoprite Philadelphia"},
                 {code: "19128", name: "Shoprite Philadelphia"},
                 {code: "19129", name: "Shoprite Philadelphia"},
                 {code: "19130", name: "Shoprite Philadelphia"},
                 {code: "19131", name: "Shoprite Philadelphia"},
                 {code: "19132", name: "Shoprite Philadelphia"},
                 {code: "19133", name: "Shoprite Philadelphia"},
                 {code: "19134", name: "Shoprite Philadelphia"},
                 {code: "19135", name: "Shoprite Philadelphia"},
                 {code: "19136", name: "Shoprite Philadelphia"},
                 {code: "19137", name: "Shoprite Philadelphia"},
                 {code: "19138", name: "Shoprite Philadelphia"},
                 {code: "19139", name: "Shoprite Philadelphia"},
                 {code: "19140", name: "Shoprite Philadelphia"},
                 {code: "19141", name: "Shoprite Philadelphia"},
                 {code: "19142", name: "Shoprite Philadelphia"},
                 {code: "19143", name: "Shoprite Philadelphia"},
                 {code: "19144", name: "Shoprite Philadelphia"},
                 {code: "19145", name: "Shoprite Philadelphia"},
                 {code: "19146", name: "Shoprite Philadelphia"},
                 {code: "19147", name: "Shoprite Philadelphia"},
                 {code: "19148", name: "Shoprite Philadelphia"},
                 {code: "19149", name: "Shoprite Philadelphia"},
                 {code: "19150", name: "Shoprite Philadelphia"},
                 {code: "19151", name: "Shoprite Philadelphia"},
                 {code: "19152", name: "Shoprite Philadelphia"},
                 {code: "19153", name: "Shoprite Philadelphia"},
                 {code: "19160", name: "Shoprite Philadelphia"},
                 {code: "19161", name: "Shoprite Philadelphia"},
                 {code: "19162", name: "Shoprite Philadelphia"},
                 {code: "19170", name: "Shoprite Philadelphia"},
                 {code: "19171", name: "Shoprite Philadelphia"},
                 {code: "19172", name: "Shoprite Philadelphia"},
                 {code: "19173", name: "Shoprite Philadelphia"},
                 {code: "19175", name: "Shoprite Philadelphia"},
                 {code: "19177", name: "Shoprite Philadelphia"},
                 {code: "19178", name: "Shoprite Philadelphia"},
                 {code: "19179", name: "Shoprite Philadelphia"},
                 {code: "19181", name: "Shoprite Philadelphia"},
                 {code: "19182", name: "Shoprite Philadelphia"},
                 {code: "19183", name: "Shoprite Philadelphia"},
                 {code: "19184", name: "Shoprite Philadelphia"},
                 {code: "19185", name: "Shoprite Philadelphia"},
                 {code: "19187", name: "Shoprite Philadelphia"},
                 {code: "19188", name: "Shoprite Philadelphia"},
                 {code: "19191", name: "Shoprite Philadelphia"},
                 {code: "19192", name: "Shoprite Philadelphia"},
                 {code: "19193", name: "Shoprite Philadelphia"},
                 {code: "19196", name: "Shoprite Philadelphia"},
                 {code: "19197", name: "Shoprite Philadelphia"},
                 {code: "19244", name: "Shoprite Philadelphia"},
                 {code: "19255", name: "Shoprite Philadelphia"},
                 {code: "19176", name: "Shoprite Philadelphia"},
                 {code: "19190", name: "Shoprite Philadelphia"},
                 {code: "19194", name: "Shoprite Philadelphia"},
                 {code: "19195", name: "Shoprite Philadelphia"}]

# Stores 
Store.create! [{name: "ShopRite of Fairless Hills", code: "B984656"}]

# Associate all products with store
shoprite = Store.find_by(code: "B984656")
shoprite.products << Product.all

# Ingredients to Products mapping
[[2,3,999],[4,7,699],[8,12,599]].each do |x| 
    Pricing.create(min_serving: x[0], max_serving: x[1], price_cents: x[2]) 
end

ug = UserGroup.create(name: "Rittenhouse Claridge", code: "CLARIDGE", delivery_times: "3pm-5pm", 
    welcome_greeting: "<b>Welcome Rittenhouse Resident</b>",
    delivery_instructions: "Leave the package with bay attendant", 
    delivery_info_message: "As a Claridge Resident, you have the convenience of picking up your order where you pick up your packages at the Claridge at any time after 5pm. Your order will be kept at the perfect temperature until as late as midnight, so feel free to show up any time before then.")

ug.create_address(street1: "201 S 18th St", city: "Philadelphia", state: "PA", 
    zipcode: "19103", phone: "2155462525", first_name: "Rittenhouse", last_name: "Claridge")
    
store_pwd = Rails.env.development? ? "test1" : ENV['SHOPRITE_PASSWORD']
pwd = Rails.env.development? ? "fitlybpo1" : "fitlybpo{last_sent_id}!"
store_email = Rails.env.development? ? "fawad@fitly.org" : "bpo{last_sent_id}@mg.fitly.org"
store_website = "https://plan.shoprite.com/User/Authenticate"

store_fairless = Store.where("name like ?", "%Fairless%").first
store_fairless.update_attributes({store_password: store_pwd, password: pwd, store_email: store_email, store_website: store_website})

# ritten house delivery zone
DeliveryZone.create(name: "6", days: "Tuesday, Thursday", user_group: ug1)

# Solids
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 1, display_unit: "oz", converted_measurement: "1 oz")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 2, display_unit: "oz", converted_measurement: "2 ozs")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 3, display_unit: "oz", converted_measurement: "3 ozs")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 4, display_unit: "oz", converted_measurement: "1/4 lb")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 5, display_unit: "oz", converted_measurement: "5 ozs")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 6, display_unit: "oz", converted_measurement: "6 ozs")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 7, display_unit: "oz", converted_measurement: "7 ozs")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 8, display_unit: "oz", converted_measurement: "1/2 lb")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 9, display_unit: "oz", converted_measurement: "9 ozs")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 10, display_unit: "oz", converted_measurement: "10 ozs")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 11, display_unit: "oz", converted_measurement: "3/4 lb")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 12, display_unit: "oz", converted_measurement: "3/4 lb")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 13, display_unit: "oz", converted_measurement: "3/4 lb")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 14, display_unit: "oz", converted_measurement: "3/4 lb")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 15, display_unit: "oz", converted_measurement: "1 lb")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 16, display_unit: "oz", converted_measurement: "1 lb")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 17, display_unit: "oz", converted_measurement: "1 lb")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 18, display_unit: "oz", converted_measurement: "1 lb")

MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 19, display_unit: "oz", converted_measurement: "1.25 lb")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 20, display_unit: "oz", converted_measurement: "1.25 lb")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 21, display_unit: "oz", converted_measurement: "1.25 lb")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 22, display_unit: "oz", converted_measurement: "1.25 lb")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 23, display_unit: "oz", converted_measurement: "1.5 lb")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 24, display_unit: "oz", converted_measurement: "1.5 lb")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 25, display_unit: "oz", converted_measurement: "1.5 lb")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 26, display_unit: "oz", converted_measurement: "1.5 lb")

MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 27, display_unit: "oz", converted_measurement: "1.75 lb")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 28, display_unit: "oz", converted_measurement: "1.75 lb")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 29, display_unit: "oz", converted_measurement: "1.75 lb")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 30, display_unit: "oz", converted_measurement: "1.75 lb")

MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 31, display_unit: "oz", converted_measurement: "2 lbs")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 32, display_unit: "oz", converted_measurement: "2 lbs")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 33, display_unit: "oz", converted_measurement: "2 lbs")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 34, display_unit: "oz", converted_measurement: "2 lbs")
MeasurementConversion.find_or_create_by(measurement_type: "solid", measurement: 35, display_unit: "oz", converted_measurement: "2 lbs")

# Liquids
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 1, display_unit: "tsp", converted_measurement: "1 tsp")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 2, display_unit: "tsp", converted_measurement: "2 tsp")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 3, display_unit: "tsp", converted_measurement: "1 TBSP")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 4, display_unit: "tsp", converted_measurement: "4 tsp")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 5, display_unit: "tsp", converted_measurement: "5 tsp")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 6, display_unit: "tsp", converted_measurement: "2 TBSPs")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 7, display_unit: "tsp", converted_measurement: "2.5 TBSPs")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 8, display_unit: "tsp", converted_measurement: "2.5 TBSPs")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 9, display_unit: "tsp", converted_measurement: "3 TBSPs")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 10, display_unit: "tsp", converted_measurement: "3.5 TBSPs")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 11, display_unit: "tsp", converted_measurement: "3.5 TBSPs")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 12, display_unit: "tsp", converted_measurement: "1/4 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 13, display_unit: "tsp", converted_measurement: "4.5 TBSPs")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 14, display_unit: "tsp", converted_measurement: "4.5 TBSPs")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 15, display_unit: "tsp", converted_measurement: "1/3 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 16, display_unit: "tsp", converted_measurement: "1/3 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 17, display_unit: "tsp", converted_measurement: "1/3 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 18, display_unit: "tsp", converted_measurement: "6 TBSPs")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 19, display_unit: "tsp", converted_measurement: "6 &amp; 1/3 TBSPs")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 20, display_unit: "tsp", converted_measurement: "6 &amp; 2/3 TBSPs")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 21, display_unit: "tsp", converted_measurement: "7 TBSPs")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 22, display_unit: "tsp", converted_measurement: "1/2 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 23, display_unit: "tsp", converted_measurement: "1/2 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 24, display_unit: "tsp", converted_measurement: "1/2 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 25, display_unit: "tsp", converted_measurement: "1/2 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 26, display_unit: "tsp", converted_measurement: "1/2 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 27, display_unit: "tsp", converted_measurement: "1/2 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 28, display_unit: "tsp", converted_measurement: "1/2 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 29, display_unit: "tsp", converted_measurement: "2/3 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 30, display_unit: "tsp", converted_measurement: "2/3 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 31, display_unit: "tsp", converted_measurement: "2/3 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 32, display_unit: "tsp", converted_measurement: "2/3 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 33, display_unit: "tsp", converted_measurement: "2/3 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 34, display_unit: "tsp", converted_measurement: "2/3 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 35, display_unit: "tsp", converted_measurement: "3/4 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 36, display_unit: "tsp", converted_measurement: "3/4 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 37, display_unit: "tsp", converted_measurement: "3/4 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 38, display_unit: "tsp", converted_measurement: "4/5 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 39, display_unit: "tsp", converted_measurement: "4/5 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 40, display_unit: "tsp", converted_measurement: "4/5 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 41, display_unit: "tsp", converted_measurement: "4/5 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 42, display_unit: "tsp", converted_measurement: "4/5 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 43, display_unit: "tsp", converted_measurement: "4/5 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 44, display_unit: "tsp", converted_measurement: "1 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 45, display_unit: "tsp", converted_measurement: "1 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 46, display_unit: "tsp", converted_measurement: "1 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 47, display_unit: "tsp", converted_measurement: "1 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 48, display_unit: "tsp", converted_measurement: "1 cup")

MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 1, display_unit: "TBSP", converted_measurement: "1 TBSP")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 2, display_unit: "TBSP", converted_measurement: "2 TBSPs")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 3, display_unit: "TBSP", converted_measurement: "3 TBSPs")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 4, display_unit: "TBSP", converted_measurement: "1/4 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 5, display_unit: "TBSP", converted_measurement: "1/3 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 6, display_unit: "TBSP", converted_measurement: "6 TBSPs")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 7, display_unit: "TBSP", converted_measurement: "7 TBSPs")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 8, display_unit: "TBSP", converted_measurement: "1/2 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 9, display_unit: "TBSP", converted_measurement: "1/2 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 10, display_unit: "TBSP", converted_measurement: "2/3 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 11, display_unit: "TBSP", converted_measurement: "2/3 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 12, display_unit: "TBSP", converted_measurement: "3/4 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 13, display_unit: "TBSP", converted_measurement: "4/5 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 14, display_unit: "TBSP", converted_measurement: "4/5 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 15, display_unit: "TBSP", converted_measurement: "1 cup")
MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 16, display_unit: "TBSP", converted_measurement: "1 cup")

MeasurementConversion.find_or_create_by(measurement_type: "liquid", measurement: 1, display_unit: "cup", converted_measurement: "1 cup")

# Set up printer for Island Ave
store_island = Store.where("name like ?", "%Island%").first
store_island.update_attributes({remote_printer_email: "fitlyprinter1@hpeprint.com"})

# set up time zone restrictions for island Ave
restricted_times = {:wednesday => ["7am-9am", "9am-11am","11am-1pm"]}
store_island = Store.includes(:zipcodes => :delivery_zone).where("name like ?", "%Island%").first
store_island.zipcodes.map(&:delivery_zone).uniq.each do |x| 
  x.update_attribute(:restricted_times, YAML.dump(restricted_times)) 
end