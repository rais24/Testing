# == Schema Information
#
# Table name: reimbursements
#
#  id                   :integer          not null, primary key
#  discount_cents       :integer          default(0), not null
#  discount_currency    :string(255)      default("USD"), not null
#  discount_percent     :integer
#  recurrence_frequency :string(255)      default("none"), not null
#  active               :boolean          default(TRUE), not null
#  user_id              :integer
#  created_at           :datetime
#  updated_at           :datetime
#

class Reimbursement < ActiveRecord::Base

  belongs_to :user

end
