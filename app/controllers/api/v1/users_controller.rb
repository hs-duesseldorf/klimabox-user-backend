module Api
  module V1
    class UsersController < ::Api::V1::BaseController
      before_action :set_user, except: [:create]
      before_action :check_current_user, except: [:create]

      def show
        @user = User.find_by(id: params[:id])
        if @user
          render json: @user, serializer: UserSerializer , status: 200
        else
          render json: { error: "Kein Nuzter gefunden" }, status: 403
        end
      end

      def create
        @user = User.new(user_params)
        if @user.save
          UserMailer.activation_needed_email(@user).deliver_now
          render json: @user, serializer: UserSerializer , status: 200
        else
          render json: { errors: @user.errors }, status: 422
        end
      end

      def update
        if @user.update(user_params)
          render json: @user, serializer: UserSerializer , status: 200
        else
          render json: { errors: @user.errors }, status: 422
        end
      end

      def destroy
        if @user.delete
          render json: {message: "User erfolgreich gelöscht"}, status: 200
        else
          render json: { error: "Da ist etwas schief gelaufen. Bitte nochmal probieren" }, status: 422
        end
      end

    private

      def set_user
        @user = User.find_by(id: params[:id])
      end

      def check_current_user
        if current_user != @user
          render json: { errors: "Kein Zugriff erlaubt" }, status: 403
        end
      end

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :admin)
      end
    end
  end
end