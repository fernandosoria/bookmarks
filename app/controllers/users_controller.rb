class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @bookmarks = current_user.bookmarks.all
    @tags = user_tags 
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
end