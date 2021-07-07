module Backend
  class FavoriteBlogpostsController < BaseController
    def index
      @posts = FavoriteBlogpost.all
    end

    def new
      @post = FavoriteBlogpost.new
    end

    def create
      @post = FavoriteBlogpost.new(posts_params)
      if @post.save
        redirect_to backend_favorite_blogposts_path
      else
        flash[:alert] = "Neuer Nutzer konnte nicht angelegt werden."
        render :new
      end
  end

    def edit
      @post = FavoriteBlogpost.find_by(id: params[:id])
    end

    def update
      @post = FavoriteBlogpost.find_by(id: params[:id])

      if @post.update(posts_params)
        flash[:success] = "Nutzer wurde bearbeitet."
        redirect_to backend_favorite_blogposts_path
      else
        flash[:alert] = "Nutzer konnte nicht bearbeitet werden."
        render :edit
      end
    end

    def destroy
      @post = FavoriteBlogpost.find_by(id: params[:id])

      if @post.destroy
        redirect_to backend_favorite_blogposts_path
      else
        # Flashmessage
      end
    end

    private
    def posts_params
      params.require(:favorite_blogpost).permit(:user_id, :slug)
    end
  end
end