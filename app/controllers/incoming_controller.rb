class IncomingController < ApplicationController
# http://stackoverflow.com/questions1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @user = User.find_by(params[:sender])
    @topic = Topic.find_by(params[:subject])

    @url = params["body-plain"]

    unless @user
      @user = User.find_by(user_name: "EverydayMan")
    end

    unless @topic
      @topic = Topic.create!(title: params[:subject], user_id: @user.id)
    end

    @bookmark = Bookmark.create!(url: @url, topic_id: @topic.id)

    # Assuming all went well.
    head 200.
  end

end
