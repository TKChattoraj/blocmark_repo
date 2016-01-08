require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:user) {create(:user)}
  let(:topic) {create(:topic, user: user)}

  it {should belong_to(:user)}
  it {should validate_presence_of(:title)}

  describe "attributes" do
    it "should respond to title" do
      expect(topic).to respond_to(:title)
    end
  end
end
