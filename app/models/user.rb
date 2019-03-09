class User < ApplicationRecord
  def self.from_google_auth(args)
    find_or_create_by(google_uid: args['uid']) do |user|
      user.name = args['info']['name']
      user.email = args['info']['email']
    end
  end
end
