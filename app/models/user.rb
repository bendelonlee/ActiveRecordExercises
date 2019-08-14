class User < ApplicationRecord
  def self.from_google_auth(args)
    find_or_create_by(google_uid: args['uid']) do |user|
      user.name = args['info']['name']
      user.email = args['info']['email']
    end
  end

  def completions(exercise)
    Completion.where(user: self, exercise: exercise)
  end

  def completed?(exercise)
    completions(exercise).any?
  end

  def times_completed(exercise)
    completions(exercise).first.times_completed
  end
end
