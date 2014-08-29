require 'rails_helper'

describe User do
  describe "#liked(bookmark)" do

    before do
      @user = create(:user)
      @bookmark_like = create(:bookmark, user: @user)
      @bookmark_unlike = create(:bookmark, user: @user)

      @like = @user.likes.create(bookmark: @bookmark_like)
    end
  
    describe "#liked(bookmark)" do
      it "returns 'nil' if user has not liked the bookmark" do
        expect(@user.liked(@bookmark_unlike)).to eq(nil)
      end

      it "returns the appropriate like if it exists" do
        expect(@user.liked(@bookmark_like)).to eq(@like)
      end
    end
  end
end