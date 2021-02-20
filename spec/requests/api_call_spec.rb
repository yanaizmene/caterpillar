# frozen_string_literal: true

RSpec.describe do
  subject do
    post '/tickets',
         params: file_fixture('payload.json').read,
         headers: { 'CONTENT_TYPE' => 'application/json' }
  end

  it 'creates ticket' do
    polygon = 'POLYGON((-81.13390268058475 32.07206917625161,' \
              '-81.14660562247929 32.04064386441295,' \
              '-81.08858407706913 32.02259853170128,' \
              '-81.05322183341679 32.02434500961698,' \
              '-81.05047525138554 32.042681017283066,' \
              '-81.0319358226746 32.06537765335268,' \
              '-81.01202310294804 32.078469305179404,' \
              '-81.02850259513554 32.07963291684719,' \
              '-81.07759774894413 32.07090546831167,' \
              '-81.12154306144413 32.08806865844325,' \
              '-81.13390268058475 32.07206917625161))'
    scope = Ticket.where(
      request_number: '09252012-00001',
      sequence_number: 2421,
      request_type: 'Normal',
      response_due_date_time: '2011/07/13 23:59:59',
      primary_service_area_code: 'ZZGL103',
      additional_service_area_codes: %w[ZZL01 ZZL02 ZZL03],
      well_known_text: polygon
    )
    expect { subject }.to change { scope.count }.from(0).to(1)
  end

  it 'creates excavator' do
    scope = Excavator.where(
      company_name: 'John Doe CONSTRUCTION',
      address: '555 Some RD SOME PARK ZZ 55555',
      crew_on_site: true
    )
    expect { subject }.to change { scope.count }.from(0).to(1)
  end

  it 'responds correctly' do
    subject
    expect(json).to eq(success: true)
    expect(response_code).to eq(201)
  end

  context 'when payload is invalid' do
    subject do
      post '/tickets',
           params: file_fixture('invalid_payload.json').read,
           headers: { 'CONTENT_TYPE' => 'application/json' }
    end

    it 'does not creates ticket' do
      expect { subject }.not_to(change { Ticket.count })
    end

    it 'does not creates excavator' do
      expect { subject }.not_to(change { Ticket.count })
    end

    it 'responds correctly' do
      subject
      expect(json).to eq(
        success: false,
        errors: ['Request number can\'t be blank']
      )
      expect(response_code).to eq(422)
    end
  end
end
