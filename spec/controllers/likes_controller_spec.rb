require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let (:my_user) {create(:user, email: "my@user.com")}
  let(:bookmark_user) {create(:user)}
  let(:my_topic) {create(:topic, user: bookmark_user)}
  let(:my_bookmark) {my_topic.bookmarks.create!(url: "http://fake_bookmark.com", user_id: bookmark_user.id)}
  let(:my_bookmark2) {my_topic.bookmarks.create!(url: "http://fake_bookmark2.com", user_id: bookmark_user.id)}
  let(:my_like) {Like.create!(user_id: my_user.id, bookmark_id: my_bookmark.id)}

  before do
    my_user.confirm
    sign_in :user, my_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "GET #index" do
    it "returns http success" do
      get :index, {bookmark_id: my_bookmark.id}
      expect(response).to have_http_status(:success)
    end

    it "sets @likes to the entire collection of Likes" do
      get :index, {bookmark_id: my_bookmark.id}
      expect(assigns(:likes)).to eq([my_like])
    end
  end

  describe "POST #create" do
    it "returns http found" do
      post :create, {bookmark_id: my_bookmark.id}
      expect(response).to have_http_status(:found)
    end

    it "increases the number of Like objects by 1" do
      expect{post :create, {bookmark_id: my_bookmark2.id}}.to change(Like, :count).by(1)
    end

    it "creates a Like object for the current_user and specified bookmark" do
      post :create, {bookmark_id: my_bookmark.id}
      expect(Like.last.user).to eq my_user
      expect(Like.last.bookmark).to eq my_bookmark
    end
  end

  describe "DELETE #destroy" do
    it "returns http found" do
      delete :destroy, {bookmark_id: my_bookmark.id, id: my_like.id}
      expect(response).to have_http_status(:found)
    end

    it "reduces the number of Like objects by 1" do
      delete :destroy, {bookmark_id: my_bookmark.id, id: my_like.id}
      like_count = Like.where(bookmark_id: my_bookmark.id, user_id: my_user.id).count
      expect(like_count).to eq 0
    end


  end

end
