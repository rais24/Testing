class RegistrationsController < ApplicationController
  skip_load_and_authorize_resource
  
  include Wicked::Wizard

  before_filter :authenticate

  steps :family, :allergies

  def show
    render_wizard
  end

  def update
    current_user.update permitted_params[:user]

    update_order(next_order)

    # when the last step is complete, and the user
    # hasn't yet activated
    if wizard_steps.last == step && !current_user.active?
      # FIX ME
      current_user.update active: true
      ActivateWorker.perform_async(current_user.id)
    end
    render_wizard(current_user)
  end

  def finish_wizard_path
    dashboard_path
  end

  protected
    def permitted_params
      params.permit user: [:first, :last, :adults, :children, allergy_ids: []]
    end
end