class BookmarksController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def show
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.create!(bookmark_params)

    if @bookmark.save
      flash[:notice] = "New Bookmark Created!"
      redirect_to @topic

    else
      flash[:error] = "Bookmark NOT Created.  Try agian."
      render_template :new
    end

  end


  def edit
    @bookmark = Bookmark.find(params[:id])
    @topic = Topic.find(@bookmark.topic_id)
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])


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
    params.require(:bookmark).permit(:url)
  end


end
