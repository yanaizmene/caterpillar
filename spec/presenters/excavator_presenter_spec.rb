# frozen_string_literal: true

RSpec.describe ExcavatorPresenter do
  describe '#crew_on_site' do
    it 'returns yes' do
      excavator = instance_double(
        Excavator, crew_on_site: true
      )
      presenter = described_class.new(excavator)
      expect(presenter.crew_on_site).to eq('Crew is on site')
    end

    it 'returns yes' do
      excavator = instance_double(
        Excavator, crew_on_site: false
      )
      presenter = described_class.new(excavator)
      expect(presenter.crew_on_site).to eq('Crew is not on site')
    end
  end
end
