require 'rails_helper'

RSpec.describe Beer, type: :model do
  let(:brewery) { Brewery.create name: 'TestBrewery', year: 2000 }
  let(:lager) { Style.create name: 'Lager' }

  it "is saved with valid input" do
    beer = Beer.create name: 'CoolBeer', style: lager, brewery: brewery

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved without a name" do
    beer = Beer.create style: lager, brewery: brewery

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.create name: "CoolBeer", brewery: brewery

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
