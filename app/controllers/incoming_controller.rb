class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_filter :verify_authenticity_token, only: [:create]

  def create
    email params[:sender]
    subject params[:subject]
    body params['body-plain']
    url = /\b(([\w-]+:\/\/?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|\/)))/i.match(body)

    puts "Email: #{email}"
    puts "Subject: #{subject}"
    puts "Body: #{body}"
    puts "URL: #{url}"

    head 200
  end
end