class UsersController < ApplicationController
  def activate
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      flash[:success] = "Nutzer wurde aktiviert."
      redirect_to "#{Rails.configuration.url["client_url"]}/signin"
    else
      flash[:alert] = "Der Nutzer wurde noch nicht aktiviert."
      not_authenticated
    end
  end
end