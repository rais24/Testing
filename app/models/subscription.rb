# == Schema Information
#
# Table name: subscriptions
#
#  id                 :integer          not null, primary key
#  subscription_type  :string(255)      default("3-meal"), not null
#  expires_on         :datetime         not null
#  paused_on          :datetime
#  resumes_on         :datetime
#  delivery_day       :string(255)      not null
#  delivery_time_slot :string(255)      not null
#  status             :string(255)      default("active"), not null
#  user_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class Subscription < ActiveRecord::Base

  has_many :billings
  has_many :orders
  has_one :weekly_delivery_schedule, dependent: :destroy
  belongs_to :user

  after_create :notify_new_subscriber
  after_create :schedule_billings_and_delivery
  after_save :notify_subscriber
  after_save :schedule_billings_and_delivery

  accepts_nested_attributes_for :weekly_delivery_schedule

  def pause(start_date, end_date)
  	paused_on = start_date
  	status = "paused"
  	resumes_on = end_date
  	save!
  end

  def resume
  	status = "active"
  	UserMailer.resume_subscription(self).deliver
  	save!
  end

  private

  def schedule_billings_and_delivery
  	if status == "active"
  		# Iterate between created_at and expires_on by 1 week at a time
  		#SubscriptionWorker.perform_at(scheduled_time, self.id)
  	end 
  end

  def notify_subscriber
  	UserMailer.pause_subscription(self).deliver if status == "paused"
  end

  def notify_new_subscriber
  	UserMailer.welcome_subscriber(self).deliver
  end


end
