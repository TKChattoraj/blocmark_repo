class BookmarksController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  after_action :verify_authorized, only: [:create, :update, :destroy]

  def show
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new

    authorize @bookmark

    respond_to do |format|
      format.html
      format.js
    end

  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.new(bookmark_params)
    @bookmark.user = current_user

    authorize @bookmark

    if @bookmark.save
      flash[:notice] = "New Bookmark Created!"
      #redirect_to @topic

    else
      flash[:error] = "Bookmark NOT Created.  Try agian."
      redirect_to new_topic_bookmark_path
    end

    respond_to do |format|
      format.html
      format.js
    end

  end


  def edit

    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
    @topic = Topic.find(@bookmark.topic_id)
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])

    authorize @bookmark
    # params[:bookmark][:created_at]

    if @bookmark.update_attributes(bookmark_params)
      flash[:notice] = "Bookmark Updated!"
      redirect_to @topic
    else
      flash[:error] = "Bookmark could not be updated.  Try again"
      render :edit
    end

  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])

    authorize @bookmark

    if @bookmark.destroy
      flash[:notice] = "Bookmark was deleted."
      redirect_to @topic
    else
      flash[:error] = "Bookmark could not be deleted.  Try again."
      render_template :show
    end

  end


  private

  def bookmark_params
    # Strong params for the bookmark
    params.require(:bookmark).permit(:url)
  end


end
