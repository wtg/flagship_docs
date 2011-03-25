class Revision < ActiveRecord::Base
  belongs_to :document

  # Handles the file attachment stuff
  # git://github.com/bamnet/attachable.git
  attachable

  scope :current, order("created_at DESC").limit(1)

end
