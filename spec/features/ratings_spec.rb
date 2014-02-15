require 'spec_helper'
include OwnTestHelper

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
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
    }.to change{Rating.count}.by(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)

  end

  describe "ratings exists" do
    before :each do
      user2 = FactoryGirl.create :user, username:'Seppo'
      FactoryGirl.create :rating, score:10, beer:beer1, user:user
      FactoryGirl.create :rating, score:10, beer:beer2, user:user
      FactoryGirl.create :rating, score:20, beer:beer1, user:user2
    end

    it "ratings are shown in the ratings page" do
      visit ratings_path
      expect(page).to have_content "Number of ratings 3"
    end

    it "own ratings are shown in the user page" do
      visit user_path(user)
      expect(page).to have_content "Has made 2 rating"
    end

    it "user can delete own rating" do
      visit user_path(user)

      expect{
        page.first('a', text:'delete').click
      }.to change{Rating.count}.by(-1)
      save_and_open_page
    end
  end
end