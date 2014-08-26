class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @bookmarks = current_user.bookmarks.all
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
end