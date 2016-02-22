class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:index]


  def index
      @topics = Topic.all
      #@bookmarks_hash = Bookmark.all.group_by(& :topic)
      @bookmarks_hash = Bookmark.all.group_by{|b| b.topic}.sort.to_h
      # @bookmarks_hash = Hash.new
      # @topics.each do |t|
      #   @bookmarks_hash[t] = t.bookmarks
      # end
  end

  def show
    @topic = Topic.find(params[:id])
    @topic_bookmarks_hash = @topic.bookmarks.group_by{|b| b.topic}.sort.to_h
  end

  def new
    @user = User.find(params[:user_id])
    @topic = Topic.new
  end

  def create

    @topic = Topic.new(topic_params)
    @topic.user_id = params[:user_id]

    if @topic.save
      flash[:notice] = "Topic Created!"
      redirect_to topic_path(@topic.id)
    else
      flash[:error] = "Error in creating the Topic.  Try Again."
      render :new
    end

  end

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.bookmarks.empty?
      if @topic.destroy
        flash[:notice] = "Topic was deleted"
        redirect_to topics_path
      else
        flash[:error] = "There was an error in deleting this topic"
        redirect_to topic_path(@topic.id)
      end
    else
      flash[:error] = "Cannot delete a topic with bookmarks!"
      redirect_to topic_path(@topic.id)
    end

  end


  private

  def topic_params
    params.require(:topic).permit(:title)
  end
end
