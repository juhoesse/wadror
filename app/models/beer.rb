class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  def average_rating
    sum = 0
    ratings.each do |r|
       sum += r.score
    end
    sum / ratings.count
  end

  def to_s
    self.name + ', ' + brewery.name
  end
end
