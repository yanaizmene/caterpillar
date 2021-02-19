# frozen_string_literal: true

RSpec.describe TicketPresenter do
  describe '#additional_area_codes' do
    it 'returns #additional_area_codes comma separated' do
      ticket = instance_double(
        Ticket, additional_service_area_codes: %w[code1 code2]
      )
      presenter = described_class.new(ticket)
      expect(presenter.additional_area_codes).to eq('code1, code2')
    end

    it 'returns "-" if no area codes' do
      ticket = instance_double(
        Ticket, additional_service_area_codes: %w[]
      )
      presenter = described_class.new(ticket)
      expect(presenter.additional_area_codes).to eq('-')
    end
  end

  describe '#due_date' do
    it 'returns #response_due_date_time' do
      datetime = Time.now.utc
      ticket = instance_double(Ticket, response_due_date_time: datetime)
      presenter = described_class.new(ticket)
      expect(presenter.due_date).to eq(datetime.strftime('%d %b %H:%M'))
    end
  end

  describe '#polygon_coords' do
    it 'returns array of coords' do
      polygon = 'POLYGON((35.1648275 23.4225383,35.7821707 23.5915249))'

      ticket = instance_double(
        Ticket,
        well_known_text: polygon
      )

      presenter = described_class.new(ticket)
      expect(presenter.polygon_coords).to eq(
        [
          { lat: 35.1648275, lng: 23.4225383 },
          { lat: 35.7821707, lng: 23.5915249 }
        ]
      )
    end

    it 'returns empty array of coords if input is nil' do
      polygon = nil
      ticket = instance_double(Ticket, well_known_text: polygon)
      presenter = described_class.new(ticket)
      expect(presenter.polygon_coords).to eq([])
    end

    it 'returns empty array of coords if input is invalid' do
      polygon = 'invalid polygon data'
      ticket = instance_double(Ticket, well_known_text: polygon)
      presenter = described_class.new(ticket)
      expect(presenter.polygon_coords).to eq([])
    end
  end
end
