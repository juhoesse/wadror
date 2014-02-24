class BeerClub < ActiveRecord::Base
  has_many :memberships
  has_many :members, through: :memberships, source: :user

  def to_s
    "#{name}, #{founded}, #{city}"
  end

  def member?(user)
    members.include? user
  end
end
