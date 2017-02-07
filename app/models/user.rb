class User < ActiveRecord::Base
  include AverageRating
  has_secure_password
  validates :username, uniqueness: true,
                        length: { in: 3..30 }
  validates :password, length: { minimum: 4 }
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships
  has_many :memberships, dependent: :destroy
  validate :password_is_correct

  def to_s
    "#{username}"
  end

  def password_is_correct
    if !( password =~ /\d/) or password == password.downcase
         errors.add(:password_is_correct, "Password must contain one upper case letter
                                            and one number!")
    end
  end

  def favorite_beer
     return nil if ratings.empty?
     ratings.order(score: :desc).limit(1).first.beer
  end


end
