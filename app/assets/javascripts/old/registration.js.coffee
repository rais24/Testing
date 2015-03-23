###
The base validator, disabling the submit button when validation fails. 
Extending classes should override the @validate() method
###
class RegistrationValidator
  ###
  Public
  ###
  constructor: (@submitButtons) -> @validate()

  validate: (valid = true) =>
    for submit in @submitButtons
      submit.disabled = !valid

###
For the Families step

A Family needs a first and last name, as well as a non-negative number of adults and children
###
class FamilyValidator extends RegistrationValidator
  constructor: (@submitButtons, @textFields, @numberFields) ->
    @textFields.change => @validate()

    @numberFields.change => @validate()

    super(@submitButtons)

  validate: (valid = true) =>
    for text in @textFields when text.value is null or !text.value.length
      valid = false

    for number in @numberFields when number.value is null or Number(number.value) < 0
      valid = false

    super(valid)

###
For the Allergies step

Allergies can be left blank

###
class AllergiesValidator extends RegistrationValidator
  constructor: (@submitButtons) -> super(@submitButtons)


###
For the Diets step

Diets can be left blank
###
class DietsValidator extends RegistrationValidator
  constructor: (@submitButtons) -> super(@submitButtons)

$ ->
  # for the Family step
  new FamilyValidator $(".registration-family input[type=submit]"),
                      $(".registration-family input[type=text].required"),
                      $(".registration-family input[type=number]")

  # for the Allergies step
  new AllergiesValidator $(".registration-allergies input[type=submit]")

  # for the Diets step
  new DietsValidator $(".registration-diets input[type=submit]")
