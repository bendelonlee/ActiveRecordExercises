require "rails_helper"
describe 'exercise index page' do
  it 'shows exercises sorted by level' do
    ex1 = create(:exercise, level: :basic)
    ex2 = create(:exercise, level: :intermediate)
    ex3 = create(:exercise, level: :advanced)

    visit exercises_path
    within('#basic-exercises') do
      expect(page).to have_css("#exercise-#{ex1.id}")
    end
    within('#intermediate-exercises') do
      expect(page).to have_css("#exercise-#{ex2.id}")
    end
    within('#advanced-exercises') do
      expect(page).to have_css("#exercise-#{ex3.id}")
    end
  end
  it "shows me how many times I've completed an exercise, if I have completed it" do
    user_extra = create(:user)
    user = create(:user)
    ex1, ex2, ex3 = create_list(:exercise, 3)
    Completion.create!(exercise: ex1, user: user, times_completed: 4)
    Completion.create!(exercise: ex2, user: user, times_completed: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user.reload)

    visit exercises_path
    within("#exercise-#{ex1.id}") do
      expect(page).to have_link(ex1.name, href: exercise_path(ex1))
      expect(page).to have_content("Completed 4 times")
    end
    within("#exercise-#{ex2.id}") do
      expect(page).to have_link(ex2.name, href: exercise_path(ex2))
      expect(page).to have_content("Completed 1 time")
    end
    within("#exercise-#{ex3.id}") do
      expect(page).to have_link(ex3.name, href: exercise_path(ex3))
      expect(page).to_not have_content("Completed")
    end
  end
end
