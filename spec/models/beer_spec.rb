require 'spec_helper'

describe Beer do

  it "is not saved without a name" do
    beer = Beer.create style:FactoryGirl.create(:style)

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.create name:"Iso 3"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  describe "with a name and style" do
    beer = Beer.create name:"Karhu", style:FactoryGirl.create(:style)

    it "is saved" do
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
  end

end
