class LikesController < ApplicationController
  def index
    @topics = Topic.all
    # @bookmarks_hash = Hash.new
    # @topics.each do |t|
    #   @bookmarks_hash[t] = t.liked_bookmarks
    # end
    @bookmarks_hash = Bookmark.liked_bookmarks.group_by{|b| b.topic}.sort.to_h
  end

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])

    @like = Like.new(bookmark_id:  @bookmark.id, user_id: current_user.id)

    if @like.save
      flash[:notice] = "You like #{@bookmark.url}!"
      #redirect_to @bookmark.topic
      redirect_to :back
    else
      flash[:error] = "Error:  Like not complete"
      #redirect_to @bookmark.topic
      redirect_to :back
    end


  end

  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    @like = Like.find(params[:id])

    if @like.destroy
      flash[:notice] = "You unliked the bookmark"
      redirect_to :back
    else
      flash[:error] = "Error!  You still like the bookmark"
      redirect_to :back
    end
  end
end
