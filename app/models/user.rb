# == Schema Information
#
# Table name: users
#
#  id                            :integer          not null, primary key
#  email                         :string(255)      default(""), not null
#  password_digest               :string(255)      default(""), not null
#  first                         :string(255)
#  last                          :string(255)
#  adults                        :integer          default(1)
#  children                      :integer          default(0)
#  password_reset_token          :string(255)      default(""), not null
#  password_reset_sent_at        :datetime
#  role                          :string(255)      default(""), not null
#  active                        :boolean          default(FALSE), not null
#  auth_token                    :string(255)      default(""), not null
#  locked                        :boolean          default(TRUE), not null
#  delivery_site_id              :integer
#  created_at                    :datetime
#  updated_at                    :datetime
#  eligible                      :boolean          default(FALSE), not null
#  zipcode                       :string(255)      default("")
#  guest                         :boolean          default(FALSE), not null
#  uid                           :string(255)
#  provider                      :string(255)
#  oauth_token                   :string(255)
#  oauth_expires_at              :datetime
#  ok_to_email                   :boolean          default(FALSE)
#  user_group_id                 :integer
#  invite_code                   :string(255)
#  weight                        :decimal(5, 2)
#  height                        :decimal(2, 1)
#  practitioner_code             :string(255)
#  dob                           :date
#  gender                        :string(255)
#  dietary_profile               :text
#  certificate_number            :string(255)
#  certificate_type              :string(255)
#  encrypted_first               :text
#  encrypted_last                :text
#  encrypted_adults              :text
#  encrypted_children            :text
#  encrypted_invite_code         :text
#  encrypted_weight              :text
#  encrypted_height              :text
#  encrypted_practitioner_code   :text
#  encrypted_dob                 :text
#  encrypted_gender              :text
#  encrypted_dietary_profile     :text
#  encrypted_certificate_number  :text
#  encrypted_certificate_type    :text
#  encrypted_zipcode             :text
#  insurer                       :string(255)
#  insurance_member_id           :string(255)
#  encrypted_insurer             :string(255)
#  encrypted_insurance_member_id :string(255)
#  business_name                 :string(255)
#  encrypted_business_name       :string(255)
#

# Public:
#   The User class represents a customer and their family.
#
#   :email         - String the email address. the unique identifier of an account
#   :first         - String their first name
#   :last          - String their last name
#   :role          - String determines the read/write privileges a user has
#   :eligible      - Boolean determines if a family is eligible, based on the following:
#                       - has at least one child
#                       - the family has no food allergies
#                       - the family has no dietary restrictions
#   :active        - Boolean determines if the user has finished their registration process and hasn't been shut off
#   :adults        - Integer the number of adults in their family
#   :children      - Integer the number of children in their family. For our pilot, they must have at least 1 child
#   :site          - DeliverySite where the User's orders will be delivered
#
class User < ActiveRecord::Base
  #include Zippable

  # A role dictates what a user can view/edit.
  #
  # :admin - A user with the admin role can read and write EVERYTHING
  # :supplier - A user responsible for handling ingredients.
  # :recipient - A user responsible for managing `site`s.
  #              Has read access to a `site`'s `users`, as well
  #              as the site itself
  ROLES = %i(admin supplier recipient)

  acts_as_taggable_on :signup_source
  acts_as_messageable

  vstr "dietary_profile" ,
    {"ok_to_discuss_with_dietician" => "bool",
     "dietary_needs" => "text",
     "dietary_preferences" => "text",
     "dietary_dislikes" => "text",
     "willingness" => "text",
     "medical_history" => "text",
     "nutrition_goals" => "text",
     "targets" => "text",
     "progress_history" => "text",
    }

  attr_encrypted :first,              :key => ENV["EKEY"]   
  attr_encrypted :last,               :key => ENV["EKEY"]    
  attr_encrypted :adults,             :key => ENV["EKEY"], :marshal => true  
  attr_encrypted :children,           :key => ENV["EKEY"], :marshal => true  
  attr_encrypted :invite_code,        :key => ENV["EKEY"]
  attr_encrypted :weight,             :key => ENV["EKEY"], :marshal => true  
  attr_encrypted :height,             :key => ENV["EKEY"], :marshal => true  
  attr_encrypted :practitioner_code,  :key => ENV["EKEY"]
  attr_encrypted :dob,                :key => ENV["EKEY"], :marshal => true
  attr_encrypted :zipcode,            :key => ENV["EKEY"]
  attr_encrypted :gender,             :key => ENV["EKEY"]
  #attr_encrypted :dietary_profile,    :key => ENV["EKEY"]
  attr_encrypted :certificate_number, :key => ENV["EKEY"]
  attr_encrypted :certificate_type,   :key => ENV["EKEY"]
  attr_encrypted :business_name,      :key => ENV["EKEY"]
  attr_encrypted :insurer,            :key => ENV["EKEY"]
  attr_encrypted :insurance_member_id,:key => ENV["EKEY"]

  has_secure_password(validations: false)

  before_validation { self.eligible = User.eligible?(self); true }
  before_validation do
    generated = [ :auth_token, :password_reset_token ]
    #generated << :email if guest?
    generate_tokens *generated
  end

  validates_presence_of :email, :password_digest, unless: :guest?
  validates_uniqueness_of :email, unless: :guest?
  validates_format_of :email, with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i, unless: :guest?

  # Requires password to contain 1 number, 1 letter, and be at least 4 characters long
  validates_format_of :password, with: /\A(?=.*[a-zA-Z])(?=.*[0-9?!]).{4,}\z/,
                      message: "must contain 1 letter, 1 number/symbol, and be at least 4 characters long",
                      if: :validate_password?

  validates_confirmation_of :password

  #validates_numericality_of :adults, greater_than: 0, less_than_or_equal_to: 15
  #validates_numericality_of :children, greater_than_or_equal_to: 0, less_than_or_equal_to: 15

  has_one :billing, dependent: :destroy
  has_one :address, as: :addressable
  has_many :shopping_carts, dependent: :destroy
  has_one :subscription, dependent: :destroy
  has_one :weekly_delivery_schedule, dependent: :destroy
  has_many :meal_plans, -> { where(active: true) }, dependent: :destroy
  belongs_to :user_group
  
  #has_and_belongs_to_many :allergies

  has_many :orders, dependent: :destroy do
    def current
      Order.current(user: proxy_association.owner).first
    end
  end

  has_many :deliveries, through: :orders do
    def current
      Delivery.current(site: proxy_association.owner.site).first
    end
  end

  accepts_nested_attributes_for :subscription

  scope :admins, ->{ where(role: 'admin') }
  scope :recipients, ->{ where.not(role: 'admin') }

  scope :guest, ->{ where(guest: true) }
  scope :registered, ->{ where(guest: false) }

  scope :eligible, ->{ where(eligible: true) }
  scope :ineligible, ->{ where(eligible: false) }

  def record_targets params
    patient_targets_list = {}
    params.each do |p,v|
      unless p.blank?
        patient_targets_list[p.to_sym] = v.to_i
      end
    end
    self.targets = patient_targets_list.to_s
  end

  def record_progress_history params
    current_progress_list = eval(self.progress_history) unless self.progress_history.blank?
    current_progress_list ||= {}
    current_progress_list.merge!({params[:date] => params.except(:date)})
    self.progress_history = current_progress_list.to_s
  end

  def record_medical_history params
    medical_history_list = {}
    params.each do |p,v|
      unless p.blank?
        if p == "other"
          medical_history_list[p.to_sym] = v
        else
          medical_history_list[p.to_sym] = 1
        end
      end
    end
    self.medical_history = medical_history_list.to_s
  end

  def record_willingness_to_change params
    willingness_list = {}
    params.split(",").each do |p|
      unless p.blank?
        category, rating = p.split(':')
        willingness_list[category.strip.to_sym] = rating.to_i
      end
    end
    self.willingness = willingness_list.to_s
  end

  def record_dietary_needs params
    needs_list = {}
    params.split(",").each do |p|
      needs_list[p.to_sym] = 1 unless p.blank?
    end
    self.dietary_needs = needs_list.to_s
  end

  def record_dietary_preferences params
    preferences_list = {}
    params.split(",").each do |p|
      preferences_list[p.to_sym] = 1 unless p.blank?
    end
    self.dietary_preferences = preferences_list.to_s
  end

  def self.eligible?(user)
    !user.guest? &&
    user.active? &&
    !user.locked? &&
    user.adults > 0 &&
    user.allergies.empty?
  end

  def self.create_guest zipcode
    create! { |u|
      u.guest = true
      u.zipcode = zipcode
      u.email = ''
      u.ok_to_email = true
      }
  end

  def targets_list
    return {} if self.targets.blank?
    eval(self.targets) 
  end

  def willingness_to_change
    return {} if self.willingness.blank?
    eval(self.willingness) 
  end

  def medical_history_record
    return {} if self.medical_history.blank?
    eval(self.medical_history) 
  end

  def progress_history_list
    return {} if self.progress_history.blank?
    eval(self.progress_history) 
  end

  def nutrition_goals_list
    return {} if self.nutrition_goals.blank?
    eval(self.nutrition_goals) 
  end

  def dietary_needs_list
    return {} if self.dietary_needs.blank?
    eval(self.dietary_needs) 
  end

  def dietary_preferences_list
    return {} if self.dietary_preferences.blank?
    eval(self.dietary_preferences) 
  end

  def dietary_dislikes_list
    return [] if self.dietary_dislikes.blank?
    self.dietary_dislikes.split(",")
  end

  def is_specialist?
    return true if self.role.present? && self.role == "specialist"
    false
  end

  def is_subscriber?
    self.subscription.present?
  end

  def validate_password?
    !guest && (!password_digest.present? || (password.present? || password_confirmation.present?))
  end

  # Public: determines if a user has a particular role
  #
  # checked_roles - Array or String the role(s) in question
  #
  # Returns true if the user has ALL checked_roles
  def is?(*checked_roles)
    checked_roles.to_a.reduce(true) do |has_role, r|
      has_role && (r.to_s == role.to_s)
    end
  end

  # Public: displays their full name
  def name
    name = "#{first} #{last}".strip
    if name.present?
      name
    else
      "Guest"
    end
  end

  def mailboxer_email(object)
    email
  end

  def name_or_email
    name.present? ? name : email
  end

  # the number of meals per family
  def family_size
    #return adults + children
    if adults + children < 4
      4
    else
      adults + children
    end
  end

  def height_in_feet
    return 0 if self.height.blank?
    self.height.to_i
  end

  def height_in_inches
    return 0 if self.height.blank?
    (10*(self.height - self.height_in_feet.to_f).round(2)).to_i
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      #user.save!
    end
  end

  def update_user_info(params)
    self.update_attributes(params.except(:height_inch, :height_ft, :phone, :state, :city, :is_specialist))
    if params[:height_ft].present? && params[:height_inch].present?
      height_val = params[:height_ft].to_f.round(1) + (params[:height_inch].to_f/12.to_f).round(1)
      self.update_attribute(:height, height_val)
    end
    ok_to_discuss_with_dietician = (params[:ok_to_discuss_with_dietician] && params[:ok_to_discuss_with_dietician] == 1)
    self.update_attribute(:role, "specialist") if params[:is_specialist] == "true"
    self.save
  end
  
  def used_promo_codes
    used = []
    orders.each do |o|
      if o.used_promo
        used << o.used_promo.code.downcase if o.used_promo.promo
      end
    end
    used
  end

  private
    def validate_zip?
      !guest?
    end

    # generate a random token
    # NOTE if a User already exists with this password reset token,
    #      we'll generate a new one
    def generate_tokens(*columns)
      columns.to_a.each do |column|
        begin
          self[column] = SecureRandom.urlsafe_base64
        end while User.exists?(column => self[column])
      end
    end
end
