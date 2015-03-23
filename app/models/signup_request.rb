class SignupRequest
  include ActiveModel::Validations

  attr_accessor :first, :last, :dob, :email, :is_specialist, :subscription, :weight, :height_ft, :height_inch
  attr_accessor :practitioner_code, :gender, :phone, :business_name, :street, :city, :state, :zipcode
  attr_accessor :certificate_type, :certificate_number, :is_specialist, :ok_to_email, :insurer, :invite_code
  attr_accessor :ok_to_discuss_with_dietician, :subscription_type, :password, :password_confirmation
  attr_accessor :name, :card_number, :card_code, :expiration_date, :delivery_day, :time_slot, :delivery_instructions
  attr_accessor :promo_code, :dietary_needs_list, :dietary_preferences_list

  validates_presence_of :first, :last, :email, :certificate_number, :certificate_type, message: "Must be provided"
  validates_presence_of :gender, :business_name, :phone, :street, :city, :state, :zipcode, :dob, message: "Must be provided"
  validates_presence_of :subscription_type, :password, message: "Must be provided"
  validates_presence_of :name, :card_number, :card_code, :expiration_date, message: "Must be provided"
  validates_presence_of :delivery_day, :time_slot, :dietary_needs_list, message: "Must be provided"

  validates_format_of :email, with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i, message: "Invalid email"
  validates_format_of :card_number, with: /[0-9]{13,16}/i, message: "Invalid email"

  validates_format_of :password, with: /\A(?=.*[a-zA-Z])(?=.*[0-9?!]).{4,}\z/,
                      message: "must contain 1 letter, 1 number/symbol, and be at least 4 characters long"
  validates_confirmation_of :password

  validate :dob_is_valid, :expiration_date_is_valid

  private 

  def dob_is_valid
    if self.dob && Date.strptime(self.dob, "%m-%d-%Y").blank?
      errors.add(:dob, "Must be MM-DD-YYYY format")
    end
  end

  def expiration_date_is_valid
    if self.expiration_date
      month_part, year_part = self.expiration_date("/")
      if month_part.split.to_i > 12
        errors.add(:expiration_date, "Month must be less than 13")
      end
      if year_part.split.to_i < Date.today.year || (month_part.split.to_i < Date.today.month && year_part.split.to_i >= Date.today.year)
        errors.add(:expiration_date, "Credit card already expired")
      end
    end
  end

end
