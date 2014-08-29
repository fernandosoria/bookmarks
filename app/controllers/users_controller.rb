class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @bookmarks = current_user.bookmarks.all
    @tags = user_tags
    @likes = tag_contains_likes
  end

  def update
    if current_user.update_attributes(user_params)
      redirect_to edit_user_registration_path, notice: "User information updated."
    else
      render "devise/registrations/edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def user_tag_ids
    @bookmarks.map do |b|
      b.tags.pluck(:id)
    end
  end

  def user_tags
    tag_ids_array = user_tag_ids.flatten

    tag_ids_array.map do |tag_id|
      Tag.find(tag_id)
    end
  end

  def user_liked_tag_ids
    @likes.map do |like|
      like.bookmark.id
    end
  end

  def tag_contains_likes
    all_tags = Tag.all
    tag_contains_liked_bookmark = []

    all_tags.map do |tag|
      # check if tag contains liked bookmarks and add to array
      if current_user.likes.find_by(bookmark_id: tag.bookmarks.map(&:id))
        tag_contains_liked_bookmark << tag.id
      end
    end

    tag_contains_liked_bookmark.reject
  end
end