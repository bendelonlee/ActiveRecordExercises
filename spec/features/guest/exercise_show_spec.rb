require "rails_helper"
describe 'excercise show page' do
  it 'has the exercise name and instruction' do
    exercise = create(:exercise)
    visit exercise_path(exercise)
    expect(page).to have_content(exercise.name)
    expect(page).to have_content(exercise.instruction)
  end
  it 'when you execute your solution, you see your results next to the results returned by the correct solution' do
    exercise = create(:exercise)
    create_list(:item, 2)
    visit exercise_path(exercise)
    fill_in :solution_solution_code, with: "Item.all"
    click_on "execute"
    expect(page).to have_content("Expected Results:")
    expect(page).to have_content("Your Query Returned:")
    expect(page).to have_content("Success!")
  end
  describe 'it keeps unpermitted code from running' do
    before(:each) do
      exercise = create(:exercise)
      create_list(:item, 2)
      visit exercise_path(exercise)
    end
    it "such as `exit`" do
      fill_in :solution_solution_code, with: "exit"
      @error = "Only activerecord queries will be executed : `exit` not permitted"
    end
    scenario "such as `binding.pry`" do
      fill_in :solution_solution_code, with: "binding.pry"
      @error = "Only activerecord queries will be executed : `binding`, `pry` not permitted"
    end
    scenario "such as `(binding.pry)`" do
      fill_in :solution_solution_code, with: "binding.pry"
      @error = "Only activerecord queries will be executed : `binding`, `pry` not permitted"
    end
    xit "such as `create`" do
      fill_in :solution_solution_code, with: "Item.create(name: 'Mr. Robot')"
      @error = "Only activerecord queries will be executed : `create` not permitted"
    end
    scenario "such as `destroy_all`" do
      fill_in :solution_solution_code, with: "Item.destroy_all"
      @error = "Only activerecord queries will be executed : `destroy_all` not permitted"
    end
    xit "such as `DROP TABLE items` inside of a string passed into sql" do
      fill_in :solution_solution_code, with: "Item.where('items.name=\"candle\"')"
      @error = "Only activerecord queries will be executed : `destroy_all` not permitted"
    end
    after(:each) do
      click_on "execute"
      expect(page).to have_content(@error)
    end
  end
  xit 'hides the solution. But when you press the "show solution" button it shows the solution. You can then press "hide solution" which hides the solution' do
    #got the functionality working with js, not sure how to test
    exercise = create(:exercise)
    visit exercise_path(exercise)
    save_and_open_page
    expect(page).to_not have_content(exercise.solution)
    click_on "show solution"
    expect(page).to have_content(exercise.solution)

  end

end
