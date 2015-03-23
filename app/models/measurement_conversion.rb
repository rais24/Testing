# == Schema Information
#
# Table name: measurement_conversions
#
#  id                    :integer          not null, primary key
#  measurement_type      :string(255)      default(""), not null
#  measurement           :integer          default(0), not null
#  display_unit          :string(255)      default(""), not null
#  converted_measurement :string(255)      default(""), not null
#  created_at            :datetime
#  updated_at            :datetime
#

class MeasurementConversion < ActiveRecord::Base

  scope :solids, -> { where(measurement_type: "solid") }
  scope :liquids, -> { where(measurement_type: "liquid") }

end
