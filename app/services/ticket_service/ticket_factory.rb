# frozen_string_literal: true

module TicketService
  module TicketFactory
    def self.build(params)
      Ticket.new(
        request_number: params['RequestNumber'],
        sequence_number: params['SequenceNumber'],
        request_type: params['RequestType'],
        response_due_date_time: params.dig('DateTimes', 'ResponseDueDateTime'),
        primary_service_area_code: params.dig(
          'ServiceArea', 'PrimaryServiceAreaCode', 'SACode'
        ),
        additional_service_area_codes: params.dig(
          'ServiceArea', 'AdditionalServiceAreaCodes', 'SACode'
        ),
        well_known_text: params.dig(
          'ExcavationInfo', 'DigsiteInfo', 'WellKnownText'
        )
      )
    end
  end
end
