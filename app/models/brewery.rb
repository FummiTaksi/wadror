
class Brewery < ActiveRecord::Base
  include AverageRating

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, length: {minimum: 1}
  validate :year_must_be_between_1042_and_present

  scope :active, -> {where active: true}
  scope :retired, -> {where active: [nil,false]}

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
    tulos = ratings.inject(0.0) {|summa,rating| summa + rating.score} / (1.0 * ratings.size)
    tulos.round(2)
  end

  def year_must_be_between_1042_and_present
    if year < 1042 or year > Time.now.year
      errors.add(:year_must_be_between_1042_and_present,",try again plz :)")
    end
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating||0) }
    sorted_by_rating_in_desc_order.take(n)
  end



  def to_s
    "#{name}, founded at #{year}"
  end

end
