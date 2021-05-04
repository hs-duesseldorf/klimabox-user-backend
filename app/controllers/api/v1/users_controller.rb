module Api
  module V1
    class UsersController < ::Api::V1::BaseController
      def show
        @user = User.find_by(id: params[:id])
        if @user
          render json: @user, serializer: UserSerializer , status: 200
        else
          render json: { error: "Kein Nuzter gefunden" }, status: 403
        end
      end
    end
  end
end