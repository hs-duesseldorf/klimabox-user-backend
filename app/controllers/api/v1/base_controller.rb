module Api
  module V1
    class BaseController < ::Api::BaseController
      skip_before_action :verify_authenticity_token
      include ActionController::Cookies

      def authenticate_cookie
        token = cookies.signed[:jwt]
        decoded_token = JsonWebToken.decode(token)
        if decoded_token
          user = User.find_by(id: decoded_token["user_id"])
        end
        if user then return true else render json: {status: 'unauthorized', code: 401} end
      end

      def current_user
        token = cookies.signed[:jwt]
        decoded_token = JsonWebToken.decode(token)
        if decoded_token
          user = User.find_by(id: decoded_token["user_id"])
        end
        if user then return user else return false end
      end
    end
  end
end