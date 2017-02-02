class Membership < ActiveRecord::Base
 belongs_to :user
 belongs_to :beer_club
 validate :cant_join_to_a_club_where_user_is



  def cant_join_to_a_club_where_user_is

     if (user.beer_clubs.include?(beer_club))
        errors.add(:cant_join_to_a_club_where_user_is, "You can't join to a club where you are")
     end
  end
end
