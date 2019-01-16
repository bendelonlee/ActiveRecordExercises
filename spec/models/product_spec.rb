require 'rails_helper'

RSpec.describe Product, type: :model do
  it "can create without errors" do
    item = Product.create(name: "candle", price: 0)
  end
end
