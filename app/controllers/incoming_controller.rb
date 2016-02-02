class IncomingController < ApplicationController
# http://stackoverflow.com/questions1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
skip_before_action :verify_authenticity_token, only: [:create]

  def create
    # Temporary Code for purposes of development only
    # This is needed because test emails are coming from only
    # one active gmail address.  Application assumes a brand new # address and so don't want to have to delete from db
    # after every test.

    #params[:sender] = "pete@rose.com"

    #
    #
    # Delete the above line when finished with the
    # testing/development
    if User.where(email: params[:sender]).empty?
      # Temporary Code for purposes of development only
      # This is needed because test emails are coming from only
      # one active gmail address.  Application assumes a brand new # address and so don't want to have to delete from db
      # after every test.
      params[:sender] = "user_#{rand(1..10000)}@email.com"
      #
      #
      # Delete the above line when finished with the
      # testing/development

      @anonymous_user = true
      @user = User.new(user_name: params[:sender], password: "password", email: params[:sender])
      @user.confirm
      @user.save

    else
      @user = User.find_by(email:  params[:sender])
    end

    if Topic.where(title: params[:subject]).empty?
      @topic = Topic.create!(title: params[:subject], user_id: @user.id)
    else
      @topic = Topic.find_by(title: params[:subject])
    end

    #@url = params["body-plain"].chomp
    @url = params["stripped-text"]

    @bookmark = Bookmark.new(url: @url, topic_id: @topic.id)

    if @bookmark.save
      if @anonymous_user
        BookmarkMailer.anonymous_bookmark_email(@user, @bookmark).deliver_now
      else
      BookmarkMailer.bookmark_email(@user, @bookmark).deliver_now
      end
    else
      # return an email to user saying it didn't work
    end

    # Assuming all went well.
    head 200
  end

end
