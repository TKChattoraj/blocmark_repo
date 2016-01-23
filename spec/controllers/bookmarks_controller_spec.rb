require 'rails_helper'

RSpec.describe BookmarksController, type: :controller do
  let(:my_user) {create(:user)}
  let(:my_topic) {create(:topic, user: my_user)}
  let(:my_bookmark) {my_topic.bookmarks.create!(url: "http://fake_bookmark.com")}

  context "user NOT signed in" do

    describe "GET #show" do
      it "redirects to the login view" do
        get :show, {topic_id: my_topic.id, id: my_bookmark.id}
        expect(response).to redirect_to (new_user_session_path)
      end
    end

    describe "GET #new" do
      it "redirects to the login view" do
        get :new, {topic_id: my_topic.id}
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "POST #create" do
      it "redirects to the login view" do
        post :create, {topic_id: my_topic.id, bookmark: {url: "http://new_bookmark.com"}}
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "GET #edit" do
      it "redirects to the login view" do
        get :edit, {topic_id: my_topic.id, id: my_bookmark.id}
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "PUT #update" do
      it "redirects to the login view" do
        put :update, {topic_id: my_topic.id, id: my_bookmark.id, bookmark: {url:  "http://revised_bookmark.com"}}
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "DELETE #destroy" do
      it "redirects to the login view" do
        delete :destroy, {topic_id: my_topic.id, id: my_bookmark.id}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end  #Context user NOT signed in

  context "signed in user" do
    before do
      my_user.confirm
      sign_in :user, my_user
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, {topic_id: my_topic.id, id: my_bookmark.id}
        expect(response).to have_http_status(:success)
      end
      it "renders the show view" do
         get :show, {topic_id: my_topic.id, id: my_bookmark.id}
         expect(response).to render_template  :show
      end
      it "sets @bookmark to the spcified bookmark" do
         get :show, {topic_id: my_topic.id, id: my_bookmark.id}
         expect(assigns(:topic)).to eq my_topic
         expect(assigns(:bookmark)).to eq my_bookmark
      end

    end

    describe "GET #new" do
      it "returns http success" do
        get :new, {topic_id: my_topic}
        expect(response).to have_http_status(:success)
      end
      it "renders the new template" do
        get :new, {topic_id: my_topic}
        expect(response).to render_template :new
      end
      it "instantiates @bookmarks" do
        get :new, {topic_id: my_topic}
        expect(assigns(:bookmark)).not_to be_nil
      end
    end

    describe "POST #create" do
      it "returns http found" do
        post :create, {topic_id: my_topic, bookmark: {url: "http://new_bookmark.com"}}
        expect(response).to have_http_status(:found)
      end

      it "redirects to the topic#view" do
        post :create, {topic_id: my_topic.id, bookmark: {url: "http://new_bookmark.com"}}
        expect(response).to redirect_to my_topic
      end

      it "increases the number of bookmarks by 1" do
        expect{post :create, {topic_id: my_topic.id, bookmark: {url: "http://special_bookmark.com"}}}.to change(Bookmark, :count).by(1)
      end

      it "creates a new bookmark with the given attributes" do
        post :create, {topic_id: my_topic.id, bookmark: {url: "http://new_bookmark.com"}}
        new_url = "http://new_bookmark.com"
        new_bookmark = Bookmark.last
        expect(new_bookmark.url).to eq new_url
        expect(new_bookmark.topic_id).to eq my_topic.id
      end
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit, {topic_id: my_topic, id: my_bookmark.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the edit view" do
        get :edit, {topic_id: my_topic.id, id: my_bookmark.id}
        expect(response).to render_template :edit
      end

      it "sets @bookmark to the applicable bookmark" do
        get :edit, {topic_id: my_topic.id, id: my_bookmark.id}
        expect(assigns(:bookmark)).to eq my_bookmark
      end

    end

    describe "Put #update" do

      it "sends http found status" do
        put :update, {topic_id: my_topic.id, id: my_bookmark.id, bookmark: {url: "http://revised_bookmark.com"}}
        expect(response).to have_http_status(:found)
      end

      it "redirects to the topic#show view" do
        put :update, {topic_id: my_topic.id, id: my_bookmark.id, bookmark: {url: "http://revised_bookmark.com"}}
        expect(response).to redirect_to my_topic
      end

      it "updates the specified bookmark with the new attributes" do
        put :update, {topic_id: my_topic.id, id: my_bookmark.id, bookmark: {url: "http://revised_bookmark.com"}}
        revised_url = "http://revised_bookmark.com"
        revised_bookmark = Bookmark.find(my_bookmark.id)
        expect(revised_bookmark.url).to eq revised_url
      end
    end

      describe "DELETE #destroy" do

        it "returns http success" do
          delete :destroy, {topic_id: my_topic.id, id: my_bookmark.id}
          expect(response).to have_http_status(:found)
        end

        it "redirects the Topics #index" do
          delete :destroy, {topic_id: my_topic.id, id: my_bookmark.id}
          expect(response).to redirect_to my_topic
        end

        it "deletes the specified bookmark" do
          delete :destroy, {topic_id: my_topic.id, id: my_bookmark.id}
          count = Bookmark.where(id: my_bookmark.id).count
          expect(count).to eq 0
        end
      end


  end # end context "signed in user"
  #
  # describe "GET #new" do
  #   it "returns http success" do
  #     get :new
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
