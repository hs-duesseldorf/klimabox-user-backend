module Api
  module V1
    class PasswordResetsController < ::Api::V1::BaseController
      def create
        @user = User.find_by(email: reset_params[:email])

        if @user
          @user.generate_reset_password_token!
          UserMailer.reset_password_email(@user).deliver_now
          return render json: { message: "Es wurde eine Email mit einem Link für das Zurücksetzen des Passworts an #{@user.email} gesendet." }, status: 200
        else
          return render json: { errors: "Es ist etwas schief gelaufen" }, status: 422
        end
      end


      def reset_pw
        @token = reset_params[:token]
        @user = User.load_from_reset_password_token(@token)

        if @user.blank?
          return render json: { errors: {
            other: "Es ist etwas schief gelaufen"
            } }, status: 422
        end

        @user.password_confirmation = reset_params[:password_confirmation]
        if @user.change_password!(reset_params[:password])
          render json: @user, serializer: UserSerializer , status: 200
        else
          return render json: { errors: @user.errors }, status: 422
        end
      end

      private

      def reset_params
        params.require(:pw_reset).permit(:email, :password, :password_confirmation, :token)
      end
    end
  end
end