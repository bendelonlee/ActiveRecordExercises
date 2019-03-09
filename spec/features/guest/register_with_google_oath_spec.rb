require "rails_helper"

describe 'As a guest' do
  it 'I register with Google' do
    stub_omniauth
    visit '/'
    click_on 'sign up'
    expect(page).to have_content("Welcome, User Jones")
  end
end
