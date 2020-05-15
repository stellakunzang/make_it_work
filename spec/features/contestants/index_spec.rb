require "rails_helper"

RSpec.describe "contestants index page" do
  it "should display the names of all contestants and projects they've worked on" do

    gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)

    recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")

    furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
    upholstery_tux = furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")

    ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
    ContestantProject.create(contestant_id: kentaro.id, project_id: upholstery_tux.id)

    visit "/contestants"

    expect(page).to have_content(gretchen.name)
    expect(page).to have_content("Projects: News Chic")
    expect(page).to have_content(kentaro.name)
    expect(page).to have_content("Projects: Upholstery Tuxedo")
  end
end
