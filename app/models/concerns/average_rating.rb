
module AverageRating
  extend ActiveSupport::Concern
  def average_rating()
    if ratings.empty?
      return 0.0
    end
    tulos =ratings.inject(0.0) {|summa,rating| summa + rating.score} /(1.0 * ratings.size)
    tulos.round(2)
  end

end