require "rails_helper"

describe 'As a guest' do
  describe 'I register with google OAuth' do
    visit '/'
    click_on 'sign up'
  end
end
