module Backend
  class CommentsController < BaseController
    def index
      @comments = Comment.all
    end

    def new
      @comment = Comment.new
    end

    def create
      @comment = Comment.new(comments_params)
      @comment.user_id = current_user.id
      if @comment.save
        redirect_to backend_comments_path
      else
        flash[:alert] = "Neues Comments konnte nicht angelegt werden."
        render :new
      end
  end

    def edit
      @comment = Comment.find_by(id: params[:id])
    end

    def destroy
      @comment = Comment.find_by(id: params[:id])

      if @comment.destroy
        redirect_to backend_comments_path
      else
        # Flashmessage
      end
    end

    private
    def comments_params
      params.require(:comment).permit(:message, :ticket_id)
    end
  end
end