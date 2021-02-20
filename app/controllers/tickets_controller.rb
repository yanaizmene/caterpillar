# frozen_string_literal: true

class TicketsController < ApplicationController
  skip_forgery_protection

  def index
    @tickets = Ticket.includes(:excavator)
                     .references(:excavator)
                     .page(params[:page] || 1)
                     .per(params[:per] || 20)
  end

  def show
    @ticket = Ticket.includes(:excavator)
                      .references(:excavator)
                      .find_by!(request_number: params[:id])
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
