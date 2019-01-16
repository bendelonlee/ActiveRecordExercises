require 'rails_helper'

RSpec.describe Customer, type: :model do
  it "can create without errors" do
    item = Customer.create(email: "123@gmail.com")
  end
end
