module Api
  module V1
    class CommentsController < ::Api::V1::BaseController
      before_action do
        authenticate_cookie
      end

      def create
        @ticket = Ticket.find_by(id: params[:id])
        @comment = Comment.new(comment_params)
        @comment.ticket = @ticket
        @comment.user = current_user
        if @comment.save
          TicketMailer.new_comment(@comment).deliver_now
          render json: @ticket, serializer: TicketSerializer , status: 200
        else
          render json: { errors: @comment.errors }, status: 422
        end
      end

      def destroy
        @comment = Comment.find_by(id: params[:id])
        if @comment.user == current_user
          if @comment.destroy
            render json: {message: "Ticket erfolgreich gelöscht"}, status: 200
          else
            render json: { error: "Da ist etwas schief gelaufen. Bitte nochmal probieren" }, status: 422
          end
        else
          render json: { error: "Da ist etwas schief gelaufen. Bitte nochmal probieren" }, status: 422
        end
      end

    private

      def comment_params
        params.require(:comment).permit(:message)
      end
    end
  end
end