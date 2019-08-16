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
      exercise.mark_completed_by(user)
      exercise.mark_completed_by(user)
      completion.reload
      expect(completion.times_completed).to eq(3)

    end

  end
end
