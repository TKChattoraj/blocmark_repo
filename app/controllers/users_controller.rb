class UsersController < ApplicationController
  before_action :authenticate_user!


  def show
    @user = User.find(params[:id])
    @user_bookmarks = @user.bookmarks
    @user_bookmarks_hash = @user_bookmarks.group_by{|b| b.topic}.sort.to_h
    @liked_bookmarks = @user.liked_bookmarks
    @user_liked_bookmarks_hash = @liked_bookmarks.group_by{|b| b.topic}.sort.to_h
  end
end
