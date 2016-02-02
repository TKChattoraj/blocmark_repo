class BookmarkMailer < ApplicationMailer

  def bookmark_email(user, bookmark)
    @user = user
    @bookmark = bookmark
    # Note:  @blockmark should be the web address for the site
    # Using ngrok to tunner to localhost for now
    # For production, need to use the production site address.
    @blocmark = "https://06c6d0d6.ngrok.io/topics"
    #
    #
    #
    mail(to: @user.email, subject: 'Got your Bookmark-Thanks')
  end

  def anonymous_bookmark_email(user, bookmark)
    @user = user
    @bookmark = bookmark
    # Note:  @blockmark should be the web address for the site
    # Using ngrok to tunner to localhost for now
    # For production, need to use the production site address.
    @blocmark = "https://06c6d0d6.ngrok.io/users/edit"
    
    #
    mail(to: @user.email, subject: "Got your Bookmark.  Please complete Sign-Up")
  end







end
