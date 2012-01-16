class User < ActiveRecord::Base
  has_many :documents
  has_many :revisions
  has_many :memberships, :dependent => :destroy
  has_many :groups, :through => :memberships

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name

  def related_documents
    (Document.joins(:revisions).where('revisions.user_id' => id) + documents).uniq
  end


end
