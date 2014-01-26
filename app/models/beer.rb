class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  #ratings.to_a.inject(0.0) { |sum, el| sum + el} /ratings.size
  def average_rating
    sum = 0
    ratings.each do |r|
       sum += r.score
    end

    average = 0.0
    average = sum / ratings.count
  end
end
