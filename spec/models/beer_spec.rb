require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is saved with proper name, style and brewery" do
    Brewery.create name: "TestBrewery", year: "2000"
    b = Brewery.find 1
    beer = Beer.create name: "CoolBeer", style: "Lager", brewery_id: b.id

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved without a name" do
    Brewery.create name: "TestBrewery", year: "2000"
    b = Brewery.find 1
    beer = Beer.create name: "", style: "Lager", brewery_id: b.id

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    Brewery.create name: "ValidHelperBrewery", year: "2000"
    b = Brewery.find 1
    beer = Beer.create name: "CoolBeer", style: "", brewery_id: b.id

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
