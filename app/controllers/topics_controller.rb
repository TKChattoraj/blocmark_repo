class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:index]


  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      flash[:notice] = "Topic Created!"
      redirect_to topic_path(@topic.id)
    else
      flash[:error] = "Error in creating the Topic.  Try Again."
      render :new
    end

  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.assign_attributes(topic_params)

    if @topic.save
      flash[:notice] = "Topic was successfully updated"
      redirect_to topic_path(@topic.id)
    else
      flash[:error] = "There was an error in updating the Topic.  Please try again."
      render :edit
    end

  end

  def destroy
    @topic = Topic.find(params[:id])
    if @topic.destroy
      flash[:notice] = "Topic was deleted"
      redirect_to topics_path
    else
      flash[:error] = "There was an error in deleting this topic"
      redirect_to topic_path(@topic.id)
    end

  end


  private

  def topic_params
    params.require(:topic).permit(:title, :user_id)
  end
end