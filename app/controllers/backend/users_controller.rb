module Backend
  class UsersController < BaseController
    def index
      @users = User.all
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        UserMailer.activation_needed_email(@user).deliver_now
        flash[:success] = "Aktivierung E-Mail wurde versendet."
        redirect_to backend_users_path
      else
        flash[:alert] = "Neuer Nutzer konnte nicht angelegt werden."
        render :new
      end
    end

    def edit
      @user = User.find_by(id: params[:id])
    end

    def update
      @user = User.find_by(id: params[:id])

      if @user.update(user_params)
        flash[:success] = "Nutzer wurde bearbeitet."
        redirect_to backend_users_path
      else
        flash[:alert] = "Nutzer konnte nicht bearbeitet werden."
        render :edit
      end
    end

    def destroy
      @user = User.find_by(id: params[:id])

      if @user.destroy
        redirect_to backend_users_path
      else
        # Flashmessage
      end
    end

    private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :admin)
    end
  end
end