class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all
  end

  def show
    @bookmarks = current_user.bookmarks.all
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark

    if @bookmark.update_attributes(bookmark_params)
      redirect_to bookmarks_path, notice: "Bookmark sucessfully saved."
    else
      render :new, error: "There was an error saving your bookmark. Please try again."
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    url = @bookmark.url

    authorize @bookmark

    if @bookmark.destroy
      redirect_to bookmarks_path, notice: "Bookmark for \"#{url}\" was deleted successfully."
    else
      redirect_to bookmarks_path, error: "There was an error deleying the bookmark."
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:url)
  end

end
