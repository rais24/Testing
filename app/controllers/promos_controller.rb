class PromosController < InheritedResources::Base
  before_filter skip_load_and_authorize_resource
  before_filter :resolve_invite_code

  def create
    if params[:promo][:code]
      promo = Promo.find_by_code params[:promo][:code]
      if promo && cart.add_promo(promo)
        redirect_to shopping_cart_path, notice: "Promotion applied"
      else
        redirect_to shopping_cart_path, alert: "Didn't recognize promotion"
      end
    end
  end

  protected
  
  def resolve_invite_code
    invite_code = params[:promo][:code]
    user_group = UserGroup.find_by_code(invite_code)
    if user_group.present? && current_user.present?
      current_user.invite_code = invite_code
      current_user.user_group = user_group 
      current_user.save!
    end
  end

  def permitted_params
    params.
      permit promo: [:code]
  end
end
