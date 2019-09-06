require "rails_helper"
describe 'exercise index page' do
  it 'when I peek at an exercise, this is indicated. I am not able to get credit for completing it until 24 hours pass.' do
    extra_user = create(:user)
    ex1 = create(:exercise, index: 1)
    TimedBlock.create(user: extra_user, exercise: ex1, expiration: 2.days.from_now )

    Student.create!(name: 'b')
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user.reload)
    visit exercise_path(ex1)
    expect(TimedBlock.count).to eq(1)
    click_on("surrender-button") # Selecting by id, but not using a hashtag. Has to do with the particulars of button_to I'm guessing. Using an hashtag fails.
    expect(TimedBlock.count).to eq(2)
    expect(page).to have_content('You will be able to complete this exercise in 24 hours')
    fill_in :solution_solution_code, with: ex1.solution
    click_on 'execute'
    visit exercises_path
    within "#exercise-#{ex1.id}" do
      expect(page).to_not have_content "Completed"
    end
  end
  it 'after I complete an exercise, I am not allowed to complete again for credit for 48 hours' do
    create(:user)
    Student.create!(name: 'b')
    user = create(:user)
    ex1 = create(:exercise, index: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user.reload)
    visit exercise_path(ex1)
    expect(TimedBlock.count).to eq(0)
    fill_in :solution_solution_code, with: ex1.solution
    click_on 'execute'
    expect(TimedBlock.count).to eq(1)
    visit exercise_path(ex1)
    expect(page).to have_content('You will be able to complete this exercise again in 48 hours')
    fill_in :solution_solution_code, with: ex1.solution
    click_on 'execute'
    visit exercises_path
    within "#exercise-#{ex1.id}" do
      expect(page).to have_content "Completed 1 times"
    end
  end
end
