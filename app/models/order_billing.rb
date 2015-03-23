# == Schema Information
#
# Table name: order_billings
#
#  id         :integer          not null, primary key
#  charged    :boolean          default(FALSE), not null
#  updated    :boolean          default(FALSE), not null
#  canceled   :boolean          default(FALSE), not null
#  trans_id   :string(255)
#  order_id   :integer
#  billing_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class OrderBilling < ActiveRecord::Base
  belongs_to :order
  belongs_to :billing

  validates_presence_of :order, :billing

  # Public: charges the Billing. NOTE this is long running and should
  #         be called from OrderBillingWorker
  #
  def charge!
    unless charged || canceled
      return true unless order.price.cents > 50
      begin
        result = Stripe::Charge.create(
          customer: billing.customer_id,
          amount: order.price.cents,
          currency: order.price.currency
        )

        update charged: true, trans_id: result.id
      rescue Stripe::CardError => e
        e.message
      end
    end
  end

  # Public: refunds the charge on the Billing
  #         NOTE this is long running and should be called from OrderBillingWorker
  #
  def refund!
    if charged && !canceled
      transaction = Stripe::Charge.retrieve(trans_id)
      if transaction.refund
        update updated: true, canceled: true
      else
        raise result.errors
      end
    end
  end

  # Public: cancels the charge on the Billing
  #         NOTE this is long running and should be called from OrderBillingWorker
  #
  def cancel!
    if charged && !canceled
      refund!
      recharge!
    end
  end

  # Public: refunds the Billing
  #         NOTE this is long running and should be called from OrderBillingWorker
  #
  def recharge!
    if charged && !canceled
      refund!
      charge!
    end
  end
end
