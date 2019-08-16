class Exercise < ApplicationRecord
  validates_presence_of :name, :solution, :instruction, :index
  enum level: [:basic, :intermediate, :advanced]

  def self.minimum_index
    minimum(:index)
  end

  def self.maximum_index
    maximum(:index)
  end

  def result
    @result ||= eval(solution)
  end

  def mark_completed_by(user)
    completion = Completion.find_or_create_by!(user: user, exercise: self)
    if completion.times_completed
      completion.times_completed += 1
    else
      completion.times_completed = 1
    end
    completion.save
  end
end
