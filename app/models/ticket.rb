# frozen_string_literal: true

class Ticket < ApplicationRecord
  has_one :excavator, inverse_of: :ticket, dependent: :restrict_with_error
  validates :request_number,
            :sequence_number,
            :request_type,
            :primary_service_area_code,
            :additional_service_area_codes,
            :response_due_date_time,
            :well_known_text,
            presence: true

  validates :request_number, uniqueness: true

  def to_param
    request_number
  end
end
