require 'rails_helper'
include Helpers

describe "Rating" do
  let!(:style) {FactoryGirl.create :style}
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery,style: style }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery,style: style }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "shows ratings count" do
    FactoryGirl.create(:rating,beer: beer1,user: user,score: 7)
    FactoryGirl.create(:rating,beer: beer2,user: user,score: 8)
    visit ratings_path
    expect(page).to have_content 'Number of ratings 2'
  end

  it "shows most active user" do
    FactoryGirl.create(:rating,beer: beer1,user: user,score: 7)
    visit ratings_path
    expect(page).to have_content 'Pekka'
  end


end