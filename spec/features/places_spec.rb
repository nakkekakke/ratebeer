require 'rails_helper'

describe "Place" do
  it "if one returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [Place.new( name: 'Oljenkorsi', id: 1 )]      
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple returned by the API, all are shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [Place.new( name: 'Oljenkorsi', id: 1),
      Place.new( name: 'Gurula', id: 2),
      Place.new( name: 'Akvaario', id: 3)]      
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Gurula"
    expect(page).to have_content "Akvaario"
  end

  it "if none returned by the API, error message is shown" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return([])
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "No places found in kumpula"
  end
end