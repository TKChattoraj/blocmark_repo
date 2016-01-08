require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:user) {create(:user)}
  let(:topic) {create(:topic, user: user)}
  let(:bookmark) {create(:bookmark, topic: topic)}

  it {should belong_to(:topic)}
  it {should validate_presence_of(:url)}
  describe "attributes" do
    it "should respond to url" do
      expect(bookmark).to respond_to(:url)
    end
  end

end
