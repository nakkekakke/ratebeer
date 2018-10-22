require 'rails_helper'

describe "Beerlist page" do
  before :all do
    Capybara.register_driver :selenium do |app|
      capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
        chromeOptions: { args: ['headless', 'disable-gpu'] }
      )
      Capybara::Selenium::Driver.new(app,
        browser: :chrome,
        desired_capabilities: capabilities
      )
    end
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  before :each do
    @brewery1 = FactoryBot.create(:brewery, name:"Koff")
    @brewery2 = FactoryBot.create(:brewery, name:"Schlenkerla")
    @brewery3 = FactoryBot.create(:brewery, name:"Ayinger")
    @style1 = Style.create name:"Lager"
    @style2 = Style.create name:"Rauchbier"
    @style3 = Style.create name:"Weizen"
    @beer1 = FactoryBot.create(:beer, name:"Nikolai", brewery: @brewery1, style: @style1)
    @beer2 = FactoryBot.create(:beer, name:"Fasterbier", brewery: @brewery2, style: @style2)
    @beer3 = FactoryBot.create(:beer, name:"Lechte Weisse", brewery: @brewery3, style: @style3)
  end

  it "shows one known beer", js:true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    expect(page).to have_content "Nikolai"
  end

  it "has beers in alphabetic order by default", js:true do
    visit beerlist_path
    expect(find('table').find('tr:nth-child(2)')).to have_content "Fasterbier Rauchbier Schlenkerla"
    expect(find('table').find('tr:nth-child(3)')).to have_content "Lechte Weisse Weizen Ayinger"
    expect(find('table').find('tr:nth-child(4)')).to have_content "Nikolai Lager Koff"
  end

  it "by clicking 'style' alphabetically sorts beers by style name", js:true do
    visit beerlist_path
    page.find("#style").click
    expect(find('table').find('tr:nth-child(2)')).to have_content "Nikolai Lager Koff"
    expect(find('table').find('tr:nth-child(3)')).to have_content "Fasterbier Rauchbier Schlenkerla"
    expect(find('table').find('tr:nth-child(4)')).to have_content "Lechte Weisse Weizen Ayinger"
  end

  it "by clicking 'brewery' alphabetically sorts beers by brewery name", js:true do
    visit beerlist_path
    page.find("#brewery").click
    expect(find('table').find('tr:nth-child(2)')).to have_content "Lechte Weisse Weizen Ayinger"
    expect(find('table').find('tr:nth-child(3)')).to have_content "Nikolai Lager Koff"
    expect(find('table').find('tr:nth-child(4)')).to have_content "Fasterbier Rauchbier Schlenkerla"
  end
end