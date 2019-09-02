require 'rails_helper'

RSpec.describe Exercise, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :instruction }
  it { should validate_presence_of :solution }
  describe 'class methods' do
    it 'minimum_index' do
      create(:exercise, index: 1)
      create(:exercise, index: 2)
      expect(Exercise.minimum_index).to eq(1)
    end
    it 'maximum_index' do
      create(:exercise, index: 1)
      create(:exercise, index: 2)
      expect(Exercise.maximum_index).to eq(2)
    end
  end
  describe 'instance methods' do
    it 'mark_completed_by' do

      user = create(:user)
      exercise = create(:exercise)
      exercise.mark_completed_by(user)

      completion = Completion.last
      expect(completion.user).to eq(user)
      expect(completion.exercise).to eq(exercise)
      expect(completion.times_completed).to eq(1)
      expect(TimedBlock.count).to eq(1)
      exercise.mark_completed_by(user)
      expect(completion.times_completed).to eq(1)
      TimedBlock.destroy_all
      exercise.mark_completed_by(user)
      completion.reload
      expect(completion.times_completed).to eq(2)
    end
    describe 'blocked?' do
      before(:each) do
        @user = create(:user)
        @exercise = create(:exercise)

      end
      scenario 'when no blocks' do
        expect(@exercise.blocked?(@user)).to eq(false)
      end
      scenario 'when expired blocks' do
        TimedBlock.create!(user: @user, exercise: @exercise, expiration: 1.days.ago)
        expect(@exercise.blocked?(@user)).to eq(false)
      end
      scenario 'when unexpired blocks' do
        TimedBlock.create!(user: @user, exercise: @exercise, expiration: 1.days.from_now)
        expect(@exercise.blocked?(@user)).to eq(true)
      end
    end
    it 'hours_until_unblocked' do
      user = create(:user)
      exercise = create(:exercise)
      TimedBlock.create!(user: user, exercise: exercise, expiration: 7.hours.from_now)
      TimedBlock.create!(user: user, exercise: exercise, expiration: 17.hours.from_now)
      expect(exercise.hours_until_unblocked(user)).to eq(17)
    end
    it 'blocked_text' do
      exercise = create(:exercise)
      extra_user = create(:user)
      TimedBlock.create!(user: extra_user, exercise: exercise, expiration: 48.hours.from_now, reason: :peeked)

      user = create(:user)
      TimedBlock.create!(user: user, exercise: exercise, expiration: 7.hours.from_now, reason: :peeked)
      expect(exercise.blocked_text(user)).to eq("You will be able to complete this exercise in 7 hours")
      TimedBlock.create!(user: user, exercise: exercise, expiration: 17.hours.from_now, reason: :success)
      expect(exercise.blocked_text(user)).to eq("You will be able to complete this exercise again in 17 hours")
    end
  end
end
