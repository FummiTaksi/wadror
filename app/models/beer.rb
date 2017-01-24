class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
    1.0 * ratings.inject(0.0){|summa,rating| summa + rating.score} /ratings.size
  end

  def to_s
    "#{name}, Brewery: #{brewery.name}"
  end
end
