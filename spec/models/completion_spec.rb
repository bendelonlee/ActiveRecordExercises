require 'rails_helper'

RSpec.describe Completion, type: :model do
  it { should belong_to :user }
  it { should belong_to :exercise }
end
