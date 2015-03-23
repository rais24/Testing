module RegistrationHelper
  def submit_text
    if wizard_steps.last == step
      "Confirm your order"
    else
      "Next"
    end
  end

  def step_class(wizard_step)
    if step == wizard_step
      :active
    elsif past_step?(wizard_step)
      :complete
    else
      :muted
    end
  end
end
