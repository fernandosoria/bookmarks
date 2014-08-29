class LikesController < ApplicationController
  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.build(bookmark: @bookmark)
    authorize like

    if like.save
      redirect_to bookmarks_path, notice: "Bookmark liked."
    else
      redirect_to bookmarks_path, error: "The was an error saving the like. Please try again."
    end    
  end

  def destroy
    like = current_user.likes.find(params[:id])
    authorize like

    if like.destroy
      redirect_to bookmarks_path, notice: "Bookmark unliked."
    else
      redirect_to bookmarks_path, error: "The was an error deleting the like. Please try again."
    end    
  end
end
