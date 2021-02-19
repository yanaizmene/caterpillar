# frozen_string_literal: true

module TicketService
  module ExcavatorFactory
    def self.build(params)
      Excavator.new(
        company_name: params.dig('Excavator', 'CompanyName'),
        address: address(params),
        crew_on_site: params.dig('Excavator', 'CrewOnsite')
      )
    end

    def self.address(params)
      [
        params.dig('Excavator', 'Address'),
        params.dig('Excavator', 'City'),
        params.dig('Excavator', 'State'),
        params.dig('Excavator', 'Zip')
      ].compact.join(' ')
    end
  end
end
