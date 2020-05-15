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
    ContestantProject.create(contestant_id: gretchen.id, project_id: upholstery_tux.id)

    visit "/contestants"

    within ".contestant-#{gretchen.id}" do
      expect(page).to have_content(gretchen.name)
      expect(page).to have_content(news_chic.name)
      expect(page).to have_content(upholstery_tux.name)
    end

    within ".contestant-#{kentaro.id}" do
      expect(page).to have_content(kentaro.name)
      expect(page).to have_content(upholstery_tux.name)
    end
  end

  it "can add project using form on project index page" do
    furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
    upholstery_tux = furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
    gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)

    visit "/contestants"

    within ".contestant-#{gretchen.id}" do
      expect(page).to have_content(gretchen.name)
      expect(page).to have_no_content(upholstery_tux.name)
    end

    visit "/projects/#{upholstery_tux.id}"

    fill_in :contestant_id, with: "#{gretchen.id}"

    click_on "Add Contestant To Project"

    visit "/contestants"

    within ".contestant-#{gretchen.id}" do
      expect(page).to have_content(gretchen.name)
      expect(page).to have_content(upholstery_tux.name)
    end
    
  end

end
