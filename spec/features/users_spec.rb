require 'spec_helper'
include OwnTestHelper

describe "User" do
  let!(:user){FactoryGirl.create :user}

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and password do not match'
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

    it "has favorite beer style and brewery shown at page" do
      brewery = FactoryGirl.create :brewery, name:"Koff"
      brewery2 = FactoryGirl.create :brewery, name:"BrewDog"
      beer1 = FactoryGirl.create :beer, name:"iso 3", style:"Lager", brewery:brewery
      beer2 = FactoryGirl.create :beer, name:"Karhu", style:"Lager", brewery:brewery
      beer3 = FactoryGirl.create :beer, name:"Punk IPA", style:"IPA", brewery:brewery2
      FactoryGirl.create :rating, score:10, beer:beer1, user:user
      FactoryGirl.create :rating, score:10, beer:beer2, user:user
      FactoryGirl.create :rating, score:9, beer:beer3, user:user

      visit user_path(user)
      #save_and_open_page
      expect(page).to have_content 'Favorite style: Lager'
      expect(page).to have_content 'Favorite brewery: Koff'
    end
  end

end