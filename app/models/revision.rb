class Revision < ActiveRecord::Base

  attachable

  validates :file_name, presence: true
  validates :file_type, presence: true
  validates :file_size, numericality: { only_integer: true }
  validates_associated :document

end
