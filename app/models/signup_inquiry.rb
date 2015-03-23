# == Schema Information
#
# Table name: signup_inquiries
#
#  id          :integer          not null, primary key
#  zipcode     :string(255)      default(""), not null
#  email       :string(255)      default(""), not null
#  invite_code :string(255)      default(""), not null
#  created_at  :datetime
#  updated_at  :datetime
#

class SignupInquiry < ActiveRecord::Base
  MAX_USERS_PER_ZIPCODE = 50000

  validates_presence_of :zipcode
  #validates_uniqueness_of :email
  validates_format_of :email, with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i

  #after_save  :submit_to_mail_chimp
  attr_reader :validation_error

  def can_service_zipcode?
    unless zipcode && !zipcode.blank?
      self.validation_error = "Zipcode not provided"
      return false
    end
      Rails.logger.debug "Total users is more 1"
    unless Zipcode.exists?(code: zipcode)
      self.validation_error = "Zipcode #{zipcode} not currently serviced"
      return false
    end
      Rails.logger.debug "Total users is more than #{User.where(zipcode: zipcode).count}"
    unless User.where(zipcode: zipcode).count < SignupInquiry::MAX_USERS_PER_ZIPCODE
      self.validation_error = "Zipcode #{zipcode} already has #{SignupInquiry::MAX_USERS_PER_ZIPCODE} users"
      return false
    end
    true
  end

  def submit_to_mail_chimp
    begin
      gb = Gibbon::API.new
      list_id = "d24161bd61" # found
      resp = gb.lists.subscribe({:id => list_id, :email => {:email => email}, :merge_vars => {:ZIPCODE => zipcode}, :double_optin => true})
    rescue Gibbon::MailChimpError => e
    end
  end

  private

  	attr_writer :validation_error

end
