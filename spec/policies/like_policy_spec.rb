require 'rails_helper'

describe LikePolicy do

  context "visitor" do
    subject {LikePolicy.new(user_current, my_like)}
    let(:user_current) {nil}

    let (:my_user) {create(:user, email: "my@user.com")}
    let(:bookmark_user) {create(:user)}
    let(:my_topic) {create(:topic, user: bookmark_user)}
    let(:my_bookmark) {my_topic.bookmarks.create!(url: "http://fake_bookmark.com", user_id: bookmark_user.id)}
    let(:my_like) {Like.create!(user_id: my_user.id, bookmark_id: my_bookmark.id)}

    it {should forbid_action(:create)}
    it {should forbid_action(:destroy)}

  end


  context "signed in user but not owner of the Like" do

    subject {LikePolicy.new(user_current, anothers_like)}

    let (:user_current) {create(:user, email: "my@user.com")}

    let(:bookmark_user) {create(:user)}
    let(:my_topic) {create(:topic, user: bookmark_user)}
    let(:my_bookmark) {my_topic.bookmarks.create!(url: "http://fake_bookmark.com", user_id: bookmark_user.id)}

    let(:anothers_like) {Like.create!(user_id: bookmark_user.id, bookmark_id: my_bookmark.id)}

    it {should permit_action(:create)}
    it {should forbid_action(:destroy)}

  end

  context "signed in user and owner of the Like" do
    subject {LikePolicy.new(user_current, my_like)}

    let (:user_current) {create(:user, email: "my@user.com")}

    let(:bookmark_user) {create(:user)}
    let(:my_topic) {create(:topic, user: bookmark_user)}
    let(:my_bookmark) {my_topic.bookmarks.create!(url: "http://fake_bookmark.com", user_id: bookmark_user.id)}

    let(:my_like) {Like.create!(user_id: user_current.id, bookmark_id: my_bookmark.id)}

    it {should permit_action(:create)}
    it {should permit_action(:destroy)}

  end
end
