require "swagger_helper"

RSpec.describe "api/v1/events", type: :request do
  path "/api/v1/events" do
    get "Retrieves all events" do
      tags "Events"
      produces "application/json"
      security [Bearer: {}]

      response "200", "events retrieved successfully" do
        schema type: :array, items: { type: :object }

        run_test!
      end
    end
  end

  path "/api/v1/events/{id}" do
    get "Retrieves a specific event" do
      tags "Events"
      produces "application/json"
      security [Bearer: {}]
      parameter name: :id, in: :path, type: :string, required: true, description: "Event ID"

      response "200", "event found" do
        schema type: :object
        run_test!
      end

      response "404", "event not found" do
        run_test!
      end
    end
  end
end
