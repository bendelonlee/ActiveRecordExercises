require 'rails_helper'

RSpec.describe User, type: :model do
  describe "instance methods" do
    it '.times_completed' do
      times = 63
      user = create(:user)
      exercise = create(:exercise)
      create(:completion, times_completed: times, user: user, exercise: exercise)
      expect(user.times_completed(exercise)).to eq(63)
    end

    it '.completions' do
      user = create(:user)
      user_2 = create(:user)
      exercise = create(:exercise)
      completion = create(:completion, user: user, exercise: exercise)
      expect(user.completions(exercise)).to eq([completion])
      expect(user_2.completions(exercise)).to eq([])
    end

    it '.completed?' do
      user = create(:user)
      user_2 = create(:user)
      exercise = create(:exercise)
      completion = create(:completion, user: user, exercise: exercise)
      expect(user.completed?(exercise)).to eq(true)
      expect(user_2.completed?(exercise)).to eq(false)
    end

  end
end
