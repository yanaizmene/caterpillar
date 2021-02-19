# frozen_string_literal: true

class TicketsController < ApplicationController
  skip_forgery_protection

  def index
    @tickets = Ticket.joins(:excavator)
                     .page(params[:page] || 1)
                     .per(params[:per] || 20)
                     .map do |ticket|
                       TicketPresenter.new(ticket)
                     end
  end

  def show
    ticket_db = Ticket.joins(:excavator).find_by!(request_number: params[:id])
    @excavator = ExcavatorPresenter.new(ticket_db.excavator)
    @ticket = TicketPresenter.new(
      ticket_db,
      i18n_datetime_format: :long
    )
  end

  def create
    ticket = TicketService.create(params)
    if ticket.persisted?
      render json: { success: true }, status: :created
    else
      render json: {
        success: false, errors: ticket.errors.full_messages
      }, status: :unprocessable_entity
    end
  end
end
