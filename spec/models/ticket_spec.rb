# frozen_string_literal: true

RSpec.describe Ticket do
  it { is_expected.to have_db_column(:id).of_type(:uuid).with_options(null: false) }
  it { is_expected.to have_db_column(:request_number).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_column(:sequence_number).of_type(:integer).with_options(null: false) }
  it { is_expected.to have_db_column(:request_type).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_column(:response_due_date_time).of_type(:datetime).with_options(null: false) }
  it { is_expected.to have_db_column(:additional_service_area_codes).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_column(:well_known_text).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
  it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }

  it { is_expected.to have_one(:excavator).inverse_of(:ticket).dependent(:restrict_with_error) }

  it { is_expected.to have_db_index(:request_number).unique(true) }

  specify 'primary_service_area_code column is array' do
    ticket = described_class.new(additional_service_area_codes: %w[a b c])
    expect(ticket.additional_service_area_codes).to eq(%w[a b c])
  end

  specify '#request_number has uniqueness validation' do
    ticket = Ticket.new(
      request_number: 'ab1',
      sequence_number: 2,
      request_type: :normal,
      response_due_date_time: Time.now,
      well_known_text: '',
      primary_service_area_code: 'a',
      additional_service_area_codes: []
    )
    expect(ticket).to validate_uniqueness_of(:request_number)
  end

  it { is_expected.to validate_presence_of(:request_number) }
  it { is_expected.to validate_presence_of(:sequence_number) }
  it { is_expected.to validate_presence_of(:request_type) }
  it { is_expected.to validate_presence_of(:primary_service_area_code) }
  it { is_expected.to validate_presence_of(:additional_service_area_codes) }
  it { is_expected.to validate_presence_of(:response_due_date_time) }
  it { is_expected.to validate_presence_of(:well_known_text) }
end
