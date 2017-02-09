require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username:"Pekka"
    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with too short password" do
    user = User.create username:"Pekka", password:"Pu1", password_confirmation:"Pu1"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a password which contains only letters" do
    user = User.create username:"Pekka", password:"Salasana", password_confirmation:"Salasana"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user: user)
      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(user, 10, 7, 20, 9)
      best = create_beer_with_rating(user, 25)
      expect(user.favorite_beer).to eq(best)
    end
  end


  describe "favorite style" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_style)
    end

    it "is the only beers style if there is only one beer" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)
      expect(user.favorite_style).to eq(beer.style)
    end

    it "is the highest rated if several rated" do
      beer = FactoryGirl.create(:beer)
      rate_beer(beer,user,1)
      beer2 = FactoryGirl.create(:beer2)
      rate_beer(beer2,user,30)
      beer3 = FactoryGirl.create(:beer3)
      rate_beer(beer3,user,10)
      expect(user.favorite_style).to eq(beer2.style)
    end

    it "is the one with the best average" do
      beer = FactoryGirl.create(:beer)
      rate_beer(beer,user,1)
      rate_beer(beer,user,50)
      beer2 = FactoryGirl.create(:beer2)
      rate_beer(beer2,user,40)
      expect(user.favorite_style).to eq(beer2.style)
    end

  end

  describe "favorite brewery" do
    let(:user){FactoryGirl.create(:user)}

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_brewery)
    end
  end
  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user)}

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end
    it "and with two ratings, has the correct average rating" do

      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)

    end

  end
  def create_beer_with_rating(user, score)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
  end

  def rate_beer(beer,user,score)
    FactoryGirl.create(:rating,score:score,beer:beer,user:user)
  end

  def create_beers_with_ratings(user, *scores)
    scores.each do |score|
      create_beer_with_rating(user, score)
    end
  end

end
