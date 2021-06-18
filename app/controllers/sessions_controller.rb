class SessionsController < ApplicationController
  def new
  end

  def create
    user = login(session_params[:email], session_params[:password])
    if user
      if user.admin
        flash[:success] = "Login erfolgreich."
        redirect_to backend_dashboard_path
      else
        logout
        flash[:error] = "Nur Administratoren haben Zugang"
        redirect_to root_path
      end
    else
      flash[:error] = "Es ist etwas schief gelaufen. Bitte überprüfe die eingegebenen Daten."
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end