require 'rails_helper'

include Helpers
describe "Beers page" do
  let!(:user) { FactoryGirl.create :user }
  let!(:style) {FactoryGirl.create :style}

  it "creates beer if name is valid" do
    sign_in(username:"Pekka", password:"Foobar1")
    visit new_beer_path
    fill_in('beer_name', with: 'Karjala')
    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(1)
  end

  it "does not create beer if name is not valid" do
    sign_in(username:"Pekka", password:"Foobar1")
    visit new_beer_path
    click_button('Create Beer')
    expect(page).to have_content 'Name is too short'

  end

end
