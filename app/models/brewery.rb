class Brewery < ActiveRecord::Base
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers


  def average_rating
    sum = 0.0
    ratings.each do |r|
      sum += r.score
    end
    sum / ratings.count
  end
end

