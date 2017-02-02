class MembershipsController < ApplicationController

  def new
    @membership = Membership.new
    @beer_clubs = BeerClub.all-current_user.beer_clubs
  end

  def create
    membership = Membership.new(membership_params)
    membership.user = current_user
    if membership.save
      redirect_to membership.beer_club
    else
      render :new
    end


  end

  private

  def membership_params
    params.require(:membership).permit(:beer_club_id)
  end

end