require 'rails_helper'

describe IncomingController do
  describe '#create' do

    before do
      @user = create(:user)
    end

    it "should insert bookmark and associate with user" do
      email = @user.email
      subject = '#programming #cis'
      body = 'https://www.bloc.io/web-development \n\n \n \n\n________________________________\n\nJohn Smith\ne john@example.com\np 555.555.1234'
      
      post :create, {:sender => email, :subject => subject, 'body-plain' => body}
      expect(@user.bookmarks.count).to eq(1)
    end

  end
end
