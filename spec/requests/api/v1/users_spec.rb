RSpec.describe "api/v1/users", type: :request do
  path "/api/v1/users" do
    get "Retrieves a list of users (Admin only)" do
      tags "Users"
      produces "application/json"
      security [Bearer: {}]

      response "200", "users retrieved successfully" do
        schema type: :array, items: { type: :object }
        run_test!
      end
    end
  end

  path "/api/v1/users/{id}" do
    get "Retrieves a specific user (Admin or self)" do
      tags "Users"
      produces "application/json"
      security [Bearer: {}]
      parameter name: :id, in: :path, type: :string, required: true, description: "User ID"

      response "200", "user found" do
        schema type: :object
        run_test!
      end

      response "404", "user not found" do
        run_test!
      end
    end
  end
end
