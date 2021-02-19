# frozen_string_literal: true

module RequestSpecHelper
  def fc2g(query = '', app_name: 'admin_portal')
    post(
      '/fc2g',
      params: {
        query: query
      },
      headers: {
        'x-app-name': app_name
      }
    )
  end

  def json
    JSON.parse(response.body, symbolize_names: true)
  end

  def response_code
    response.code.to_i
  end
end

RSpec.configure { |config| config.include RequestSpecHelper }
