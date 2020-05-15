require "rails_helper"

RSpec.describe "project's show page" do
  it "should display the project's name and material" do
    recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")

    visit "/projects/#{news_chic.id}"

    expect(page).to have_content(news_chic.name)
    expect(page).to have_content(news_chic.material)
  end

  it "should also display the theme of the challenge it belongs to" do
    recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")

    visit "/projects/#{news_chic.id}"

    expect(page).to have_content("Recycled Material")
  end

  it "should display a count of the number of contestants who worked on project" do
    gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)

    furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
    upholstery_tux = furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")

    ContestantProject.create(contestant_id: kentaro.id, project_id: upholstery_tux.id)
    ContestantProject.create(contestant_id: gretchen.id, project_id: upholstery_tux.id)

    visit "/projects/#{upholstery_tux.id}"

    expect(page).to have_content("Number of Contestants: 2")
  end

  it "should display average years of contestants experience who worked on project" do
    gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)

    furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
    upholstery_tux = furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")

    ContestantProject.create(contestant_id: kentaro.id, project_id: upholstery_tux.id)
    ContestantProject.create(contestant_id: gretchen.id, project_id: upholstery_tux.id)

    visit "/projects/#{upholstery_tux.id}"

    expect(page).to have_content("Average Contestant Experience: 10")
  end
end
