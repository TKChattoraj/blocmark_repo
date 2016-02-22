require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:visitor) {nil}
  let(:my_user) {create(:user)}
  let(:topic) {create(:topic)}
  let(:other_user) {create(:user, email: "other@user.com")}
  let(:liked_bookmark) {topic.bookmarks.create!(url: "http://likedbookmark.com", user_id: other_user.id)}
  let(:my_bookmark) {topic.bookmarks.create!(url: "http://mybookmark.com", user_id: my_user.id)}

  before do
    my_user.confirm

    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  context "Visitor" do

    describe "GET #show" do
      it "redirects to the user sign in page" do
        get :show, {id: my_user.id}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context "Signed in User" do
    before do
      sign_in :user, my_user
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, {id: my_user.id}
        expect(response).to have_http_status(:success)
      end
      it "renders the users#show view" do
        get :show, {id: my_user.id}
        expect(response).to render_template :show
      end

      it "assigns all of my_user's bookmarks to @user_bookmarks" do
        get :show, {id: my_user.id}
        expect(assigns(:user_bookmarks)).to eq ([my_bookmark])
      end

      it "assigns all of my_user's liked bookmarks to @liked_bookmarks" do
        get :show, {id: my_user.id}
        Like.create!(user_id:  my_user.id, bookmark_id: liked_bookmark.id)
        expect(assigns(:liked_bookmarks)).to eq([liked_bookmark])
      end
    end
  end

end
