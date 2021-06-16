module Api
  module V1
    class SessionsController < ::Api::V1::BaseController
      before_action only: [:show] do
        authenticate_cookie
      end

      def show
        if current_user
          render json: current_user, serializer: UserSerializer, status: 200
        else
          render json: {errors: "Kein Nutzer eingeloggt"}, status: 403
        end
      end

      def authenticate
        command = AuthenticateUser.call(login_params[:email], login_params[:password])

        if command.success?
          @user = User.find_by(email: login_params[:email])
          cookies.signed[:jwt] = {value: command.result, httponly: true}
          render json: @user, serializer: UserSerializer , status: 200
        else
          render json: { error: command.errors }, status: :unauthorized
        end
      end

      private

      def login_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end