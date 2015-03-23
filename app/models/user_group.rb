# == Schema Information
#
# Table name: user_groups
#
#  id                    :integer          not null, primary key
#  name                  :string(255)      not null
#  user_count            :integer          default(0), not null
#  code                  :string(255)      not null
#  welcome_greeting      :text             not null
#  delivery_instructions :text             not null
#  delivery_times        :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  delivery_info_message :text
#

class UserGroup < ActiveRecord::Base
  has_many :users
  has_one :delivery_zone
  has_one :address, as: :addressable
  has_one :delivery_zone

  validates_presence_of :name, :code, :welcome_greeting, :delivery_instructions

  default_scope { order('TRIM(LOWER(name)) asc') }

end
