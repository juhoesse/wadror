class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
            length: {minimum: 3, maximum: 15}
  validates :password, length: {minimum: 4}, format: {with: /(?=.*[A-Z])(?=.[\d])/}

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  def year_cannot_be_in_future
    if contains_one_alpha("")
      errors.add(:year, "can't be in the future")
    end
  end
end
