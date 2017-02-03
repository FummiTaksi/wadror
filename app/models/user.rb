class User < ActiveRecord::Base
  include AverageRating
  has_secure_password
  validates :username, uniqueness: true,
                        length: { in: 3..30 }
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships
  has_many :memberships, dependent: :destroy
  validate :password_is_correct

  def to_s
    "#{username}"
  end

  def password_is_correct
    if password.length < 4 or  !( password =~ /\d/) or password == password.downcase
         errors.add(:password_is_correct, "Password has to be at least 4 digits long, contain one upper case letter
                                            and one number!")
    end
  end


end
