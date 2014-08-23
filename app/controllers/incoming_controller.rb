class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_filter :verify_authenticity_token, only: [:create]

  def create
    email = params[:sender]
    subject = params[:subject]
    body = params['body-plain']
    url = /\b(([\w-]+:\/\/?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|\/)))/i.match(body)

    # lookup user by email
    @user = User.find_by_email(email)

    # if email in User db, then create and add bookmark
    # if @user.id

      # create bookmark
      @bookmark = Bookmark.new()

      # associate bookmark to user
      @bookmark.user = @user

      # split subject to seperate tags into array
      @tags = subject.split('#').map(&:strip)

      # associate tags with @bookmark
      @bookmark.tags = @tags

      # Add URL to bookmark
      @bookmark.url = url

      @bookmark.save
    # end

    head 200
  end
end