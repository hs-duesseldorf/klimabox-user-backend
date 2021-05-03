class UsersController < ApplicationController
  def activate
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      flash[:success] = "Nutzer wurde aktiviert."
      redirect_to new_session_path
    else
      flash[:alert] = "Der Nutzer wurde noch nicht aktiviert."
      not_authenticated
    end
  end
end