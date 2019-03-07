require "rails_helper"

describe 'As a guest' do
  it 'I register with google OAuth' do
    stub_omniauth
    visit '/'
    click_on 'sign up'
  end
end
