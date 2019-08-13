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
    School::Student.create!(name: 'a')
    School::Student.create!(name: 'b')

    visit exercise_path(exercise)
    fill_in :solution_solution_code, with: "Student.all"
    click_on "execute"
    within "#expected" do
      expect(page).to have_content("Expected Results:")
#       expect(page).to have_content(/
#       <ActiveRecord::Relation [
# <Student id: 498,
#  name: "MyString",
#  price: 1,
#  created_at: "2019-01-19 19:20:11",
#  updated_at: "2019-01-19 19:20:11">,
#
# <Student id: 499,
#  name: "MyString",
#  price: 1,
#  created_at: "2019-01-19 19:20:11",
#  updated_at: "2019-01-19 19:20:11">]>/)
    end
    expect(page).to have_content("Your Query Returned:")
    expect(page).to have_content("Success!")
  end
  describe 'gives an error message if the code generates an error' do
    before(:each) do
      exercise = create(:exercise)
      School::Student.create!(name: 'a')
      School::Student.create!(name: 'b')

      visit exercise_path(exercise)
    end
    scenario 'a basic syntax error' do
      @solution = "Student.where(price: 98"
      @error = "syntax error, unexpected end-of-input, expecting ')'"
    end
    scenario 'a column that does not exist' do
      @solution = "Student.where(dragon: 'puff')"
      @error = "ERROR: column students.dragon does not exist"
    end
    after(:each) do
      fill_in :solution_solution_code, with: @solution
      click_on "execute"
      expect(page).to have_content(@error)
      within "#solution_solution_code" do
        expect(page).to have_content(@solution)
      end
    end
  end
  describe 'it keeps unpermitted code from running' do
    before(:each) do
      exercise = create(:exercise)
      School::Student.create!(name: 'a')
      School::Student.create!(name: 'b')

      visit exercise_path(exercise)
    end
    scenario "such as `exit`" do
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
    scenario 'such as `Student.where( binding.pry )`' do
      fill_in :solution_solution_code, with: "Student.where(binding.pry)"
      @error = "Only activerecord queries will be executed : `binding`, `pry` not permitted"
    end
    xit "such as `create`" do
      fill_in :solution_solution_code, with: "Student.create(name: 'Mr. Robot')"
      @error = "Only activerecord queries will be executed : `create` not permitted"
    end
    scenario "such as `destroy_all`" do
      fill_in :solution_solution_code, with: "Student.destroy_all"
      @error = "Only activerecord queries will be executed : `destroy_all` not permitted"
    end
    xit "such as `DROP TABLE students` inside of a string passed into sql" do
#       Not sure how to write a hack that I need to worry about. PG seems to already be looking out for this
#       in rails console, when I enter:
#             Student.where("students.name='candle'); SELECT students.name FROM students WHERE (students.name='candle'")
#       the sql generated is:
#             SELECT  "students".* FROM "students" WHERE (students.name='candle'); SELECT students.name FROM students WHERE (students.name='candle') LIMIT $1
#       and I get this error:
#             ActiveRecord::StatementInvalid: PG::SyntaxError: ERROR:  cannot insert multiple commands into a prepared statement
#       I get the same error when I try to insert a sneaky DROP TABLE like so:
#             where("students.name='candle'); DROP TABLE students; SELECT students.name FROM students WHERE (students.name='candle'")
#       And the table is not dropped
      fill_in :solution_solution_code, with: "Student.where('students.name=\"candle\"')"
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
