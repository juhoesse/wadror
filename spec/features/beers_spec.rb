require 'spec_helper'
include OwnTestHelper
BeerClub
BeerClubsController
MembershipsController

describe "Beer" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "is saved when name typed" do
    visit new_beer_path
    fill_in('beer[name]', with:'Iso 3')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)

    expect(current_path).to eq(beers_path)
    expect(page).to have_content "Iso 3"
  end

  it "is redirected back when name invalid" do
    visit new_beer_path
    fill_in('beer[name]', with:'')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.by(0)

    expect(current_path).to eq(beers_path)
    expect(page).to have_content "Name can't be blank"
  end
end