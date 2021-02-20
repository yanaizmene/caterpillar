# frozen_string_literal: true

class TicketPresenter < SimpleDelegator
  def self.represent(ticket, params = {})
    yield new(ticket, params)
  end

  attr_reader :params

  def initialize(ticket, params = {})
    @params = { i18n_datetime_format: :short }.merge(params)
    super(ticket)
  end

  def additional_area_codes
    return '-' if additional_service_area_codes.empty?

    additional_service_area_codes.join(', ')
  end

  def due_date
    I18n.l(response_due_date_time, format: params[:i18n_datetime_format])
  end

  def polygon_coords
    pattern = /POLYGON\(\((.*)\)\)/
    return [] unless well_known_text
    return [] unless well_known_text =~ pattern

    coords = well_known_text[pattern, 1]
    coords.split(',').map do |pair|
      lat_lng = pair.split(' ')
      { lat: lat_lng[0].to_f, lng: lat_lng[1].to_f }
    end
  end
end
