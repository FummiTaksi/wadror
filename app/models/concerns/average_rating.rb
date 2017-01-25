
module AverageRating
  extend ActiveSupport::Concern
  def average_rating()
    if ratings.empty?
      return 0.0
    end
    ratings.inject(0.0) {|summa,rating| summa + rating.score} /(1.0 * ratings.size)
  end

end