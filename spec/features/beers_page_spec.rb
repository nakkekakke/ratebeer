require 'rails_helper'

describe "Beer page" do
  before :each do
    FactoryBot.create(:brewery)
    FactoryBot.create(:user)
    FactoryBot.create(:style)
    sign_in(username: "Pekka", password: "Foobar1")
  end

  it "a beer is added to the system if name is valid" do
    visit new_beer_path
    fill_in('beer[name]', with: 'CoolBeer')

    expect {
      click_button 'Create Beer'      
    }.to change{ Beer.count }.from(0).to(1)
  end

  it "is not added to the system if name is invalid" do
    visit new_beer_path

    expect {
      click_button 'Create Beer'
    }.to change{ Beer.count }.by(0)
  end

  it "page shows error message if name is invalid" do
    visit new_beer_path
    click_button 'Create Beer'

    expect(page).to have_content("Name can't be blank")
  end
end