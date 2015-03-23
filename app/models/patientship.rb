# == Schema Information
#
# Table name: patientships
#
#  id              :integer          not null, primary key
#  patient_id      :integer          not null
#  practitioner_id :integer          not null
#  active          :boolean          default(TRUE), not null
#  created_at      :datetime
#  updated_at      :datetime
#

class Patientship < ActiveRecord::Base
  #attr_accessible :patient_id, :practitioner_id, :active
  belongs_to :patient, class_name: "User"
  belongs_to :practitioner, class_name: "User"
end
