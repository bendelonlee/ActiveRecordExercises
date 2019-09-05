class Exercise < ApplicationRecord
  validates_presence_of :name, :solution, :instruction, :index, :level
  enum level: [:basic, :intermediate, :advanced]
  has_many :timed_blocks

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
    return if blocked?(user)
    completion = Completion.find_or_create_by!(user: user, exercise: self)
    if completion.times_completed
      completion.times_completed += 1
    else
      completion.times_completed = 1
    end
    completion.save
    TimedBlock.create!(exercise: self, user: user, expiration: 2.days.from_now, reason: :success)
  end

  def blocked?(user)
    current_blocks(user).any?
  end

  def blocked_text(user)
    block = relevant_block(user)
    return nil unless block
     "You will be able to complete this exercise \
#{block.success? ? 'again ' : ''}\
in #{hours_until_unblocked(user)} hours"
  end

  def hours_until_unblocked(user)
    seconds = relevant_block(user).expiration - Time.now
    (seconds / (3600)).round
  end

  private

  def relevant_block(user)
    current_blocks(user).order(expiration: :desc).first
  end

  def current_blocks(user)
    timed_blocks.where('expiration > ?', Time.now).where(user: user)
  end
end
