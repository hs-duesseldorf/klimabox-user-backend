module Api
  module V1
    class TicketsController < ::Api::V1::BaseController
      before_action :authenticate_cookie

      def index
        @ticket = current_user.tickets
        if @ticket
          render json: @ticket, each_serializer: TicketSerializer , status: 200
        else
          render json: { error: "Kein Nuzter gefunden" }, status: 403
        end
      end

      def show
        @ticket = current_user.tickets.find_by(id: params[:id])
        if @ticket
          render json: @ticket, serializer: TicketSerializer , status: 200
        else
          render json: { error: "Kein Ticket gefunden" }, status: 403
        end
      end

      def create
        @ticket = Ticket.new(ticket_params)
        current_user.tickets << @ticket
        if current_user.save
          TicketMailer.new_ticket(@ticket).deliver_now
          render json: @ticket, serializer: TicketSerializer , status: 200
        else
          render json: { errors: @ticket.errors }, status: 422
        end
      end

      def destroy
        @ticket = Ticket.find_by(id: params[:id])
        if @ticket.destroy
          render json: {message: "Ticket erfolgreich gelöscht"}, status: 200
        else
          render json: { error: "Da ist etwas schief gelaufen. Bitte nochmal probieren" }, status: 422
        end
      end

    private

      def ticket_params
        params.require(:ticket).permit(:message)
      end
    end
  end
end