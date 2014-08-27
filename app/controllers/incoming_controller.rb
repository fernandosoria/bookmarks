class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_filter :verify_authenticity_token, only: [:create]

  def create
    email = params[:sender]
    subject = params[:subject]
    body = params['body-plain']
    url = /\b(([\w-]+:\/\/?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|\/)))/i.match(body)[1]

    # lookup user by email
    @user = User.find_by_email(email)

    # if email in User db, then create and add bookmark
    if @user.id

      # create and associate bookmark to user
      @bookmark = @user.bookmarks.build()

      # split subject to seperate tags into array and reject any empty tags
      @tags = subject.scan(/#+[a-zA-Z0-9]*/i).map{|e| e.gsub(/#/,'')}


      # associate tags with @bookmark
      @tags.each do |tag|
        tag = @bookmark.tags.build(label: tag)
        tag.save!
      end

      # Add URL to bookmark
      @bookmark.url = url

      @bookmark.save
    end

    head 200
  end
end