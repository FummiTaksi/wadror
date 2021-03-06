class BeerClub < ActiveRecord::Base
  has_many :users, through: :memberships
  has_many :memberships

  def to_s
    "#{name} , founded in #{founded} at #{city}"
  end
end
