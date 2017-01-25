
class Beer < ActiveRecord::Base
  include AverageRating
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  def average_rating
    1.0 * ratings.inject(0.0){|summa,rating| summa + rating.score} /ratings.size
  end

  def to_s
    "#{name}, Brewery: #{brewery.name}"
  end

  def sum_of_ratings
    ratings.inject(0.0){|summa,rating| summa + rating.score}
  end

end
