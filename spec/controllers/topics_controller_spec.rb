require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  let(:my_user) {create(:user)}
  let(:my_topic) {create(:topic, user: my_user)}

  context "user NOT signed in" do
    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
      it "renders the index view" do
        get :index
        expect(response).to render_template :index
      end
      it "assigns the all topics collection to @topics" do
        get :index
        expect(assigns(:topics)).to eq([my_topic])
      end
    end

    describe "GET #show" do
      it "redirects to the login view" do
        get :show, id: my_topic.id
        expect(response).to redirect_to (new_user_session_path)
      end
    end

    describe "GET #new" do
      it "redirects to the login view" do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "GET #edit" do
      it "redirects to the login view" do
        get :edit, {id: my_topic.id}
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "PUT #update" do
      it "redirects to the login view" do
        put :update, {id: my_topic.id, topic: {title: "Updated Title"}}
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "DELETE #destroy" do
      it "redirects to the login view" do
        delete :destroy, {id: my_topic.id}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end  #Context user NOT signed in

  context "Signed in User" do
    before do
      my_user.confirm
      sign_in :user, my_user
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    describe "GET #index" do
      it "should return http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "should render the index view" do
        get :index
        expect(response).to render_template :index
      end

      it "should set the collection of topics to @topics" do
        get :index
        expect(assigns(:topics)).to eq([my_topic])
      end
    end

    describe "GET #show" do
      it "should return http success" do
        get :show, id: my_topic.id
        expect(response).to have_http_status(:success)
      end

      it "should render the show view" do
        get :show, id: my_topic.id
        expect(response).to render_template :show
      end

      it "should set the chosen topic to @topic" do
        get :show, id: my_topic.id
        expect(assigns(:topic)).to eq Topic.find(my_topic.id)
        expect(assigns(:topic)).to eq my_topic
      end
    end

    describe "GET #new" do
      it "should return http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "should render the new view" do
        get :new
        expect(response).to render_template(:new)
      end

      it "should instantiate @topic" do
        get :new
        expect(assigns(:topic)).to_not be_nil
      end
    end

    describe "POST create" do
      # it "should return http success" do
      #   post :create, topic: {title: "New Topic Title", user_id: my_user.id}
      #   expect(response).to have_http_status(:found)
      # end

      it "should render the Topic#show view" do
        post :create, topic: {title: "New Topic Title", user_id: my_user.id}
        expect(response).to redirect_to topic_path(Topic.last.id)
      end

      it "should create a new Topic with the given attributes" do
        post :create, topic: {title: "New Topic Title", user_id: my_user.id}
        title = "New Topic Title"
        expect(Topic.last.title).to eq title
      end

      it "should increase the number of topics by 1" do
        expect{post :create, topic: {title: "new Topic Title", user_id: my_user.id}}.to change(Topic, :count).by(1)
      end
    end

    describe "GET edit" do

      it "should return http success" do
        get :edit, id: my_topic.id
        expect(response).to have_http_status(:success)
      end

      it "should render the #edit view" do
        get :edit, id: my_topic.id
        expect(response).to render_template :edit
      end

      it "should set @topic to the appropriate topic" do
        get :edit, id: my_topic.id
        expect(assigns(:topic)).to eq Topic.find(my_topic.id)
      end
    end

    describe "PUT update" do
      it "should render the Topic#show view" do
        put :update, id: my_topic.id, topic: {title: "Revised Topic Title"}
        expect(response).to redirect_to action: :show
      end

      it "should update the specified topic with the appropriate attributes" do
        put :update, id: my_topic.id, topic: {title: "Revised Topic Title"}
        expect(Topic.find(my_topic.id).title).to eq "Revised Topic Title"
      end
    end

    describe "DELETE destroy" do
      it "should render the Topic#index view" do
        delete :destroy, id: my_topic.id
        expect(response).to redirect_to action: :index
      end

      it "should delete the specified topic" do
        delete :destroy, id: my_topic.id
        count = Topic.where(my_topic.id).count
        expect(count).to eq 0
      end
    end
  end  #end context signed in user

end
