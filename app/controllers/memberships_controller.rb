class MembershipsController < ApplicationController

  def new
    @membership = Membership.new
    @beer_clubs = BeerClub.all-current_user.beer_clubs
  end

  def create
    membership = Membership.new(membership_params)
    membership.user = current_user
    if membership.save
      redirect_to membership.beer_club,notice: "#{current_user}, welcome to the club!"
    else
      render :new
    end

  end

  def destroy
    user = @membership.user
    @membership.destroy
    redirect_to user,notice: "Membership in #{beerclub} has ended"
  end

  private

  def membership_params
    params.require(:membership).permit(:beer_club_id)
  end

end