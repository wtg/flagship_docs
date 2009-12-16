class Background < ActiveRecord::Base

  #Relationships
  has_many :categories

  #Attachment
  has_attached_file :image
end
