class Signup
  MAX_USERS_PER_ZIPCODE = 50000

  attr_reader :validation_error

  def initialize (options={})
    @zipcode = options[:zipcode]
    @invite_code = options[:invite_code]
  end

  def is_valid?
    unless Zipcode.exists?(code: zipcode)
      self.validation_error = "#{zipcode} not currently serviced"
      return false
    end

    unless User.where(zipcode: zipcode).count <= SignupInquiry::MAX_USERS_PER_ZIPCODE
      self.validation_error = "#{zipcode} has currently more than #{SignupInquiry::MAX_USERS_PER_ZIPCODE} users" 
      return false
    end
  end

  private 

  attr_writer :validation_error
  attr_accessor :zipcode, :invite_code
end
