require 'rails_helper'

describe IncomingController do
  describe '#create' do

    before do
      @user = create(:user)
    end

    it "should create bookmark with url, user_id and tags" do
      email = @user.email
      subject = '#programming #cis'
      body = 'https://www.bloc.io/web-development \n\n \n \n\n________________________________\n\nJohn Smith\ne john@example.com\np 555.555.1234'
      
      post :create, {:sender => email, :subject => subject, 'body-plain' => body}

      bookmark = @user.bookmarks.first

      expect(@user.bookmarks.count).to eq(1)
      expect(bookmark.tags.map(&:label)).to eq(['programming','cis'])
      expect(bookmark.url).to eq('https://www.bloc.io/web-development')
    end

    it "should filter only hashtags" do
      email = @user.email
      subject = 'Fw: #programming #javascript awesome article #webdevelopment'
      body = 'http://lifehacker.com/eloquent-javascript-teaches-you-javascript-for-free-1614045478 \n\n \n \n\n________________________________\n\nJohn Smith\ne john@example.com\np 555.555.1234'
      
      post :create, {:sender => email, :subject => subject, 'body-plain' => body}

      bookmark = @user.bookmarks.first
      expect(bookmark.tags.map(&:label)).to eq(['programming','javascript','webdevelopment'])
    end

  end
end
