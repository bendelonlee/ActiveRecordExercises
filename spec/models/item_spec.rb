require "rails_helper"

RSpec.describe Item, type: :model do
  it "can create without errors" do
    item = Item.create(name: "candle", price: 0)
  end
end
