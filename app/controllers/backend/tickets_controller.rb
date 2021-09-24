module Backend
  class TicketsController < BaseController
    def index
      @tickets = Ticket.all
    end

    def new
      @ticket = Ticket.new
    end

    def create
      @ticket = Ticket.new(tickets_params)
      if @ticket.save
        TicketMailer.new_ticket(@ticket).deliver_now
        redirect_to backend_tickets_path
      else
        flash[:alert] = "Neues Tickets konnte nicht angelegt werden."
        render :new
      end
  end

    def edit
      @ticket = Ticket.find_by(id: params[:id])
    end

    def update
      @ticket = Ticket.find_by(id: params[:id])

      if @ticket.update(tickets_params)
        flash[:success] = "Ticket wurde bearbeitet."
        redirect_to backend_tickets_path
      else
        flash[:alert] = "Ticket konnte nicht bearbeitet werden."
        render :edit
      end
    end

    def destroy
      @ticket = Ticket.find_by(id: params[:id])

      if @ticket.destroy
        redirect_to backend_tickets_path
      else
        # Flashmessage
      end
    end

    private
    def tickets_params
      params.require(:ticket).permit(:user_id, :status, :message)
    end
  end
end