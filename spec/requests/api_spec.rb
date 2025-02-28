require 'swagger_helper'

RSpec.describe 'API Documentation', type: :request do
  path '/status' do
    get('Check API status') do
      tags 'Status'
      produces 'application/json'
      response(200, 'successful') do
        run_test!
      end
    end
  end
end
