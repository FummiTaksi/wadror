require 'rails_helper'

include Helpers

describe "User" do
  let!(:user) {FactoryGirl.create(:user)}
  let!(:user2) {FactoryGirl.create(:user2)}
  describe "who has signed up" do

    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end

  end

  it "shows users ratings" do
    create_beer_with_rating(user, 5)
    visit user_path(user)
    expect(page).to have_content 'anonymous 5'
  end

  it "does not show other ratings" do
     create_beer_with_rating(user,5)
     visit user_path(user2)
    expect(page).to have_content 'Has made 0 ratings'
  end

  it "doesnt show favorite brewery if no ratings" do
    sign_in(username:"Pekka", password:"Foobar1")
    visit user_path(user)
    expect(page).not_to  have_content "favorite brewery"
  end

  it "shows favorite brewery if there is one" do
    sign_in(username:"Pekka", password:"Foobar1")
    create_beer_with_rating(user,6)
    expect(page).to have_content "Favorite brewery"
  end

  it "shows favorite style if there is one" do
    sign_in(username:"Pekka", password:"Foobar1")
    create_beer_with_rating(user,7)
    expect(page).to have_content "Favorite style"
  end

  it "doesnt show favorite style if no ratings" do
    sign_in(username:"Pekka", password:"Foobar1")
    visit user_path(user)
    expect(page).not_to have_content "favorite style"
  end

  it "deletes rating" do
    create_beer_with_rating(user,5)
    sign_in(username:"Pekka", password:"Foobar1")
    visit user_path(user)
    click_link('delete')
    expect(page).to have_content 'Has made 0 ratings'
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  def create_beer_with_rating(user, score)
    brewery = FactoryGirl.create(:brewery)
    beer = FactoryGirl.create(:beer, brewery: brewery)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
  end



end