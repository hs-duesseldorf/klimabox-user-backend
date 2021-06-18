module Api
  module V1
    class FavoriteBlogpostsController < ::Api::V1::BaseController
      before_action :authenticate_cookie
      before_action :set_post, except: [:create, index]

      before_action :check_current_user, except: [:create]


      def index
        @posts = current_user.favorite_blogposts
      end

      def show
        @post
      end

      def create
        @post = FavoriteBlogpost.new(posts_params)
        if @post.save
          render json: @post, serializer: FavoriteBlogpostSerializer , status: 200
        else
          render json: { errors: @post.errors }, status: 422
        end
      end

      def destroy
        if @post.delete
          render json: {message: "Eintrag erfolgreich gelöscht"}, status: 200
        else
          render json: { error: "Da ist etwas schief gelaufen. Bitte nochmal probieren" }, status: 422
        end
      end

      private

      def set_post
        @post = FavoriteBlogpost.find_by(id: params[:id])
      end

      def check_current_user
        if current_user != @user
          render json: { errors: "Kein Zugriff erlaubt" }, status: 403
        end
      end

      def posts_params
        params.require(:favorite_blogpost).permit(:user_id, :slug)
      end
    end
  end
end