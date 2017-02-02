class User < ActiveRecord::Base
  include AverageRating
  validates :username, uniqueness: true,
                        length: { in: 3..30 }
  has_many :ratings
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships
  has_many :memberships

  def to_s
    "#{username}"
  end
end
