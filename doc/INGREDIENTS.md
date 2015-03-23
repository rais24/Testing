# Ingredients

To view the list of ingredients, go to https://fitly.org/ingredients

When viewing a particular ingredient, it tells you its:

* name
* category (meat, produce, grocery)
* whether it is a pantry item
* the recipes it is included in

Before you add an ingredient, make sure you have:

* high resolution photo that will act as its thumbnail


## Adding Ingredients

* Go to https://fitly.org/ingredients/new
* Fill in the name
* Select a category
* Determine if it is a pantry item
* Select the photo to act as its thumbnail

## Renaming Ingredients

* If an ingredient has to be renamed, go to its edit page (https://fitly.org/ingredients/ingredient-name/edit) where 'ingredient-name' is the dashified name of the ingredient
* Fill in the name field with a new name
* Click Save

**NOTE:** The ingredient's URL will still be based off its old name.
If an ingredient is named 'pita bread', its URL is '/ingredients/pita-bread'. When renamed to 'whole wheat pita bread', the URL will remain '/ingredients/pita-bread'. There is currenly no way to change this via the site. For the Rails savvy:

```console
# from the fitly-rails directory on your machine
cap console
```

Once you're in the remote console, run

```ruby
# ... For 'pita bread' -> 'whole wheat pita bread'
Ingredient.find_by(slug: 'pita-bread').update!(slug: 'whole-wheat-pita-bread')
```
