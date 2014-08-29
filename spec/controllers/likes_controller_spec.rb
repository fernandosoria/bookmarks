require 'rails_helper'

describe LikesController do

  include Devise::TestHelpers

  before do
    @bookmark = create(:bookmark)
    @user = create(:user)
    sign_in @user
  end

  describe '#create' do
    it "creates a like for current user and specified bookmark" do
      expect(@user.likes.find_by_bookmark_id(@bookmark.id)).to eq(nil)

      post :create, {bookmark_id: @bookmark.id}

      expect(@user.likes.find_by_bookmark_id(@bookmark.id).class).to eq(Like)
    end
  end

  describe '#destroy' do
    it "destroys the like for current user and bookmark" do
      like = @user.likes.where(bookmark: @bookmark).create
      expect(@user.likes.find_by_bookmark_id(@bookmark.id).class).to eq(Like)

      delete :destroy, {bookmark_id: @bookmark.id, id: like.id}

      expect(@user.likes.find_by_bookmark_id(@bookmark.id)).to eq(nil)
    end
  end
end