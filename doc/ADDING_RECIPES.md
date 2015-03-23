# Adding Recipes

Adding Recipes is a multi-step process. Before starting, make sure that you:

* Have a High-Resolution image for the recipe, as well as each Ingredient that it requires. You can skip ingredients that are already in the system, so feel free to check beforehand.

* Prepping Instructions

* Nutritional Information

* A Link to the site you're getting the recipe from

## Creating the Recipe

* First, go to https://fitly.org/recipes/new

* Fill out the following:
  * Name: name the recipe
  * Description: summarize the recipe, or give it a tagline
  * Choose File: the high resolution image that will serve as the Recipe's thumbnail
  * Dinner, Lunch, Dessert: categorize the recipe by meal
  * Prep Time: number of minutes to prepare (not cook)
  * Cook Time: number of minutes to cook
  * Preparation: Step by step prepping instructions
  * Nutrition: As much nutritional information as possible. Try to keep the formatting to `key: value`

    ```
    Fat: 1g
    Sodium: 1g
    ```
  * Source/Where Did You Find it?: paste in the link to the page where you found the recipe
  * Make sure that the `Published` checkbox is unchecked.
  * Click `Create`

## Adding the Ingredients

Once created, the recipe should be in the `Unpublished` section of https://fitly.org/recipes/. Go to the recipe's page, then click the `Edit` button. You can also short-circuit this whole process by going to https://fitly.org/recipes/slugified-name/edit (where 'slugified-name' is the dashified name of the recipe). For instance, if the new recipe is `Pepperoni Pizza`, you could go the page https://fitly.org/recipes/pepperoni-pizza/edit. If you can't seem to guess the new URL, find it through the `/recipes` page.

Before you start adding ingredients, make sure that the sizes are normalized to 1 serving. For instance, if the recipe is for Hamburgers and the yield is 4, it would call for 4 burger buns. Our system needs the ingredients in servings of 1, so divide 4 burger buns by the yield (4 / 4 = 1). Enter in the ingredient as 1.

**NOTE: UNITS**

Our system deals with the smallest possible unit for each ingredient, then rounds up when possible. This means that cups must be converted to teaspoons and pounds must be converted to ounces.

This means that if 4 `Turkey Hamburgers` requires 1 pound of `ground turkey` and yields 4, you'll need to convert the unit to the smallest for its type (weight -> oz, volume -> tsp, other -> unit) .. 1 pound -> 16oz.

**NOTE** Our system assumes that the amounts input for a recipe are in servings of 4. This means that if a recipe yields 3, 5, 6, etc. you'll need to convert it to 4.

If `ground turkey` isn't already in the system, you'll have to add that.

Go to https://fitly.org/ingredients/new and fill out the form. Once the ingredient is added, it should be in the list on the recipe form page.

## Finally

When you deem the recipe ready to go, go to its edit page, check the `Published` checkbox, and click `Save Changes`
