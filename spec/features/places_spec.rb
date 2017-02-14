require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if several is returned by the API, they are shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1), Place.new(name:"Chang",id: 2)]
    )
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    expect(page).to have_content "Chang"
    expect(page).to have_content "Oljenkorsi"
  end

  it "if none is returned by the API,correct text is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return([])
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    save_and_open_page
    expect(page).to have_content "No locations in kumpula"
  end
end