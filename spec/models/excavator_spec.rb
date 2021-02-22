# frozen_string_literal: true

RSpec.describe Excavator do
  it { is_expected.to have_db_column(:id).of_type(:integer).with_options(null: false) }
  it { is_expected.to have_db_column(:company_name).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_column(:address).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_column(:crew_on_site).of_type(:boolean).with_options(null: false) }
  it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
  it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }

  it { is_expected.to belong_to(:ticket).inverse_of(:excavator) }

  it { is_expected.to validate_presence_of(:company_name) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:crew_on_site) }
end
