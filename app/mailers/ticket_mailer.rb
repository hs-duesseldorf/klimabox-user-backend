class TicketMailer < ApplicationMailer
  def new_ticket(ticket)
    @ticket = ticket
    mail(to: 'info@klimabox.de', subject: "Neues Ticket")
  end

  def new_comment(comment)
    @comment = comment
    mail(to: 'info@klimabox.de', subject: "Neuer Kommentar")
  end
end