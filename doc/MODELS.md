# Recipes

> Chicken Caesar Salad, Grilled Cheese, etc

A **Recipe** represents a meal. It contains data such as its name, `cook_time` / `prep_time`, `steps`, `photo`, nutritional information, etc.

They are categorize (by their `meal` property) into the typical `dinners` / `lunches` / `desserts`

They can be accessed via the `/recipes` page.

A **Recipe** can be shown/hidden from the general public by setting its `published` flag.

# Ingredients

> Whole Wheat Pasta, Parmesan Cheese, Olive Oil, etc

An **Ingredient** represents a component of a recipe. It has a `name`, `photo`, a `category` (`meats` / `produce` / `groceries`), etc

A **Recipe** `has_many` ingredients through its `portions`.

## Portions

A **Portion** (whether it be **RecipePortion** or **OrderPortion**) is just an association between an object and an **Ingredient** with an attached `quantity`

For instance, a **Recipe** for Peanut Butter and Jelly has **RecipePortions** (with specific quantities) for Peanut Butter, Jelly, and Bread.

**NOTE** RecipePortions should be considered in **servings of 1** 

The PB & J's **RecipePortions** would look like the following:

<table>
  <tr>
    <th>Recipe</th>
    <th>Quantity</th>
    <th>Ingredient</th>
  </tr>
  <tr>
    <td>PB & J</td>
    <td>1 / 4 Cup</td>
    <td>Peanut Butter</td>
  </tr>
  <tr>
    <td>PB & J</td>
    <td>1 / 4 Cup</td>
    <td>Jelly</td>
  </tr>
  <tr>
    <td>PB & J</td>
    <td>2 slices</td>
    <td>Bread</td>
  </tr>
</table>

Likewise, if there was a **Recipe** for a Turkey Sandwich, its **RecipePortions** would look like the following:

<table>
  <tr>
    <th>Recipe</th>
    <th>Quantity</th>
    <th>Ingredient</th>
  </tr>
  <tr>
    <td>Turkey Sandwich</td>
    <td>1 / 4 pound</td>
    <td>Turkey</td>
  </tr>
  <tr>
    <td>Turkey Sandwich</td>
    <td>2 slices</td>
    <td>Bread</td>
  </tr>
</table>

**NOTE** This **Recipe** also needs 2 slices of bread.

# Orders

An **Order** is basically a collection of **Recipe** objects with two different views.

**OrderPortions** behave just like **RecipePortions**, except they're an association between **Orders** and **Ingredients** instead.

**OrderServings** behave similar to **OrderPortions**, except they're an association between **Orders** and **Recipes**

The shopper cares about **OrderServings** (the meals they're receiving), while the supplier cares about **OrderPortions** (the ingredients the shopper is buying)

## Order Portions

Let's continue the example from before.

I'm a **User** and I'm shopping for a family of **4**.

My cart is empty.

I want to add **PB & J** to my cart. In order to do so, an **OrderServing** between my cart (the **Order**) and the **Recipe** (**PB & J**) is created, with a `quantity` of **4** (the **User's** `family_size`.

<table>
  <tr>
    <th>Recipe</th>
    <th>Quantity</th>
  </tr>
  <tr>
    <td>PB & J</td>
    <td>4</td>
  </tr>
</table>

From this **OrderServing**, we create **OrderPortions** for each **Ingredient** involved, multiplying the **RecipePortion** quantity by the `family_size`. This means that if **1** serving of **PB & J** needs `1 / 4 cup` of Peanut Butter, then **4** servings need `1 cup`

<table>
  <tr>
    <th>Quantity</th>
    <th>Ingredient</th>
  </tr>
  <tr>
    <td>1 Cup</td>
    <td>Peanut Butter</td>
  </tr>
  <tr>
    <td>1 Cup</td>
    <td>Jelly</td>
  </tr>
  <tr>
    <td>8 slices</td>
    <td>Bread</td>
  </tr>
</table>

Next, we add **4** servings of **Turkey Sandwich**. 

<table>
  <tr>
    <th>Recipe</th>
    <th>Quantity</th>
  </tr>
  <tr>
    <td>PB & J</td>
    <td>4</td>
  </tr>
  <tr>
    <td>Turkey Sandwich</td>
    <td>4</td>
  </tr>
</table>

Now when we're adding the **Turkey Sandwich's** **OrderPortions**, we have to be careful with the `quantities`.

**Turkey** isn't already in our cart, so we simply add it. However, **Bread** was included as an **OrderPortion** when we added **PB & J** to the cart. This means that we have to tally the previous `quantity` for **Bread** along with the **Turkey Sandwich's** Bread **RecipePortion's** quantity.

<table>
  <tr>
    <th>Quantity</th>
    <th>Ingredient</th>
  </tr>
  <tr>
    <td>1 Cup</td>
    <td>Peanut Butter</td>
  </tr>
  <tr>
    <td>1 Cup</td>
    <td>Jelly</td>
  </tr>
  <tr>
    <td>1 Pound</td>
    <td>Turkey</td>
  </tr>
  <tr>
    <td>16 slices</td>
    <td>Bread</td>
  </tr>
</table>

# Delivery Site

We aggregate the delivery of **Orders** to a single location, a **DeliverySite**

a **DeliverySite** both `has_many` **Users** and **Deliveries**
