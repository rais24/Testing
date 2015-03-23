module DashboardHelper
  def dashboard_layout(user)
    if user.is?(:admin) && params[:layout].present?
      params[:layout]
    elsif !user.guest? && user.locked?
      :locked
    else
      :checkout
    end
  end

  def call_to_action_method
    current_user.billing ? :PUT : :POST
  end

  def eligible_users
    @eligible ||= User.where(eligible: true)
  end

  def percentage_of(total)
    eligible_users.count / total
  end

  def recipes
    next_order.recipes
  end
end
