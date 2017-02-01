
class Brewery < ActiveRecord::Base
  include AverageRating
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers
  validates :name, length: {minimum: 1}
  validates :year, numericality: {greater_than_or_equal_to: 1042,
                                  less_than_or_equal_to: 2017}

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2016
    puts "changed year to #{year}"
  end

  def average_rating
    if ratings.size == 0
      return 0.0
    end
    ratings.inject(0.0) {|summa,rating| summa + rating.score} / (1.0 * ratings.size)
  end

end
