require 'rails_helper'

describe "Beer" do
  let!(:brewery) { FactoryBot.create :brewery, name: 'CoolBrewery' }

  it "is added to the system if name is valid" do
    visit new_beer_path
    fill_in('beer[name]', with: 'CoolBeer')
    select('Weizen', from: 'beer[style]')
    select(brewery.name, from: 'beer[brewery_id]')

    expect {
    click_button 'Create Beer'      
    }.to change{ Beer.count }.from(0).to(1)

    expect(brewery.beers.count).to eq(1)
  end

  it "is not added to the system if name is invalid" do
    visit new_beer_path
    fill_in('beer[name]', with: '')
    select('Weizen', from: 'beer[style]')
    select(brewery.name, from: 'beer[brewery_id]')
    click_button 'Create Beer'

    expect(brewery.beers.count).to eq(0)    
  end

  it "page shows error message if name is invalid" do
    visit new_beer_path
    fill_in('beer[name]', with: '')
    select('Weizen', from: 'beer[style]')
    select(brewery.name, from: 'beer[brewery_id]')
    click_button 'Create Beer'

    expect(page).to have_content('Name can\'t be blank')
  end
end