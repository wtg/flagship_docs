class Group < ActiveRecord::Base

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :categories

  def leaders
    memberships = Membership.where(group_id: id, level: Membership::LEVELS[:leader])
  end

  def members
    regular_members = Membership.where(group_id: id, level: Membership::LEVELS[:regular])
  end

  def leader_names
    names = Array.new
    leaders.each { |leader| names << leader.user.username }
    names.join(", ")
  end

  def member_names
    names = Array.new
    members.each { |member| names << member.user.username }
    names.join(", ")
  end

  def category_names
    names = Array.new
    categories.each { |cat| names << cat.name }
    categories.join(", ")
  end

  def documents 
    documents = Array.new
    categories = Category.where(group_id: id)
    categories.each do |cat| 
      cat.documents.each do |doc|
        documents << doc
      end
    end
    documents
  end

end