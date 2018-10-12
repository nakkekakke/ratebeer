require 'rails_helper'

describe "Place" do
  before :each do
    allow(ApixuApi).to receive(:weather_in).with("kumpula").and_return(
      {"last_updated_epoch"=>1539363624,
        "last_updated"=>"2018-10-12 20:00",
        "temp_c"=>10.0,
        "temp_f"=>50.0,
        "is_day"=>0,
        "condition"=>
         {"text"=>"Mist",
          "icon"=>"//cdn.apixu.com/weather/64x64/night/143.png",
          "code"=>1030},
        "wind_mph"=>5.6,
        "wind_kph"=>9.0,
        "wind_degree"=>160,
        "wind_dir"=>"SSE",
        "pressure_mb"=>1026.0,
        "pressure_in"=>30.8,
        "precip_mm"=>0.0,
        "precip_in"=>0.0,
        "humidity"=>100,
        "cloud"=>75,
        "feelslike_c"=>8.8,
        "feelslike_f"=>47.9,
        "vis_km"=>3.0,
        "vis_miles"=>1.0}
        )
  end

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