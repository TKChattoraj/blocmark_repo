require 'rails_helper'



describe BookmarkPolicy do
  subject {BookmarkPolicy.new(user_current, bookmark)}

  let(:user) {create(:user, email: "user@user.com")}
  let(:topic) {create(:topic, user: user)}
  let(:topic2) {create(:topic, user: user)}

  let(:bookmark) {Bookmark.create!(url: "http://sample.com", topic_id: topic.id, user_id: user.id)}

  context "for a visitor" do
    let(:user_current) {nil}

    it {should forbid_action(:create)}
    it {should forbid_action(:update)}
    it {should forbid_action(:destroy)}
  end

  context "for a signed in user not owning subject Bookmark" do

      let(:user_current) {create(:user)}
      #user_current.confirm
      #sign_in :user, user_current
      #@request.env["devise.mapping"] = Devise.mappings[:user]

      it {should permit_action(:create)}

      it {should forbid_action(:update)}

      it {should forbid_action(:destroy)}

  end

  context "for a signed in user who owns the subject bookmark" do
      let(:user_current) {create(:user)}
      let(:bookmark) {Bookmark.create!(url: "http://sample1.com", topic_id: topic.id, user_id: user_current.id)}
      # user_current = user
      # sign_in :user, user_current
      # @request.env["devise.mapping"] = Devise.mappings[:user]


      it {should permit_action(:create)}

      it {should permit_action(:update)}

      it {should permit_action(:destroy)}

  end
end
