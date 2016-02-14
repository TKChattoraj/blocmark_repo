require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) {create(:user)}
  let(:topic) {create(:topic, user: user)}
  let(:bookmark) {Bookmark.create!(url: "http://sample.com", topic_id: topic.id, user_id: user.id)}
  let(:like) {Like.create!(user_id: user.id, bookmark_id: bookmark.id)}

  it {should belong_to(:user)}
  it {should belong_to(:bookmark)}
  

  describe "attributes user_id and bookmark_id" do
    it "should respond to user_id" do
      expect(like).to respond_to(:user_id)
    end
    it "should respond to bookmark_id" do
      expect(like).to respond_to(:bookmark_id)
    end
  end
end
