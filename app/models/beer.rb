
class Beer < ActiveRecord::Base
  include AverageRating
  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user
  validates :name, length: {minimum: 1}
  validates :style, presence: true

  def average_rating
    if ratings.count == 0
      return 0
    end
    summa  = 1.0 * ratings.inject(0.0){|summa,rating| summa + rating.score} /ratings.size
    summa.round(2)
  end

  def to_s
    "#{name}, Brewery: #{brewery.name}"
  end

  def sum_of_ratings
    ratings.inject(0.0){|summa,rating| summa + rating.score}
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating||0) }
    sorted_by_rating_in_desc_order.take(n)
  end

end
