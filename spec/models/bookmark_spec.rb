require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:user) {create(:user)}
  let(:topic) {create(:topic, user: user)}
  let(:topic2) {create(:topic, user: user)}

  let(:bookmark) {Bookmark.create!(url: "http://sample.com", topic_id: topic.id)}

  it {should belong_to(:topic)}
  it {should validate_presence_of(:url)}
  it {should validate_presence_of(:topic)}
  # it {should_not allow_value(3).for(:topic_id)}
  # it {should validate_inclusion_of(:topic_id).in_array(Topic.ids)}
  it {should allow_value("http://sample.com").for(:url)}
  it {should allow_value("hTTp://SamplE.COm").for(:url)}
  it {should allow_value("www.sample.com").for(:url)}
  it {should_not allow_value("htp//sample.com").for(:url)}
  it {should_not allow_value("http://.com").for(:url)}
  it {should_not allow_value("http://sample.").for(:url)}
  describe "attributes" do
    it "should respond to url" do
      # byebug
      puts topic.id
      puts topic2.id
      puts Topic.ids
      expect(bookmark).to respond_to(:url)
    end

    it "should not allow a non-existant topic_id" do
      bookmark.topic_id = 3
      expect(bookmark.valid?).to eq(false)
    end
  end

end
