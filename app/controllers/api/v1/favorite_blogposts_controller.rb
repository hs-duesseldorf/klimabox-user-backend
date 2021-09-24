module Api
  module V1
    class FavoriteBlogpostsController < ::Api::V1::BaseController
      before_action :authenticate_cookie

      def favorits
        @posts = current_user.favorite_blogposts
        render json: { slugs: @posts.map(&:slug)}
      end

      def favorise
        @post = FavoriteBlogpost.new(user: current_user, slug: posts_params[:slug])
        if @post.save
          render json: @post, serializer: FavoriteBlogpostSerializer , status: 200
        else
          render json: { errors: @post.errors }, status: 422
        end
      end

      def defavorise
        @post = FavoriteBlogpost.find_by(slug: posts_params[:slug])
        if @post.delete
          render json: {message: "Eintrag erfolgreich gelöscht"}, status: 200
        else
          render json: { error: "Da ist etwas schief gelaufen. Bitte nochmal probieren" }, status: 422
        end
      end

      private

      def posts_params
        params.require(:favorite_blogpost).permit(:slug)
      end
    end
  end
end