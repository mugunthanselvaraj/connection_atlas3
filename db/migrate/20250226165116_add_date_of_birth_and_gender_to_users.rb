class AddDateOfBirthAndGenderToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :gender, :integer, default: 0, null: false # Default to "not_specified"
  end
end
