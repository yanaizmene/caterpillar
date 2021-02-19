# frozen_string_literal: true

module TicketService
  def self.create(params)
    ticket = TicketFactory.build(params)
    ticket.excavator = ExcavatorFactory.build(params)
    ticket.save
    ticket
  end
end
