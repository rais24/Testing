module SignupHelper
  def headers
    @headers ||= [{
      text: "Get your kids to eat healthy.",
      classes: "active"
    }, {
      text: "Never worry about meal planning again."
    }, {
      text: "Eat the freshest & healthiest foods."
    }, {
      text: "Free delivery to your workplace."
    }]
  end
end
