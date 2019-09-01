class Exercise < ApplicationRecord
  validates_presence_of :name, :solution, :instruction, :index
  enum level: [:basic, :intermediate, :advanced]
  has_many :timed_blocks

  def self.minimum_index
    # These methods would be improved with some form of caching as they rarely change
    minimum(:index)
  end

  def self.maximum_index
    maximum(:index)
  end

  def result
    @result ||= eval(solution)
  end

  def mark_completed_by(user)
    return if blocked?(user)
    completion = Completion.find_or_create_by!(user: user, exercise: self)
    if completion.times_completed
      completion.times_completed += 1
    else
      completion.times_completed = 1
    end
    completion.save
  end

  def blocked?(user)
    current_blocks.any?
  end

  def hours_until_unblocked(user)
    seconds = current_blocks.order(expiration: :desc).first.expiration - Time.now
    (seconds / (3600)).round
  end

  private

  def current_blocks
    timed_blocks.where('expiration > ?', Time.now)
  end
end
