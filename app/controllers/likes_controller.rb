class LikesController < ApplicationController
  def index
    @likes = Like.all
  end

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])

    @like = Like.new(bookmark_id:  @bookmark.id, user_id: current_user.id)

    if @like.save
      flash[:notice] = "You like #{@bookmark}!"
      redirect_to @bookmark.topic
    else
      flash[:error] = "Error:  Like not complete"
      redirect_to @bookmark.topic
    end


  end

  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    @like = Like.find(params[:id])

    if @like.destroy
      flash[:notice] = "You unliked the bookmark"
      redirect_to @bookmark.topic
    else
      flash[:error] = "Error!  You still like the bookmark"
      redirect_to @bookmark.topic
    end
  end
end
