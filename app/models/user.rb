class User < ActiveRecord::Base

  has_many :documents
  has_many :revisions
  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships
  
end
