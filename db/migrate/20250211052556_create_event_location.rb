class CreateEventLocation < ActiveRecord::Migration[7.1]
  def change
    create_table :event_locations do |t|
      t.float :laltitude, null: false
      t.float :longitude, null: false
      t.string :name, null: true
      t.references :event, null: false, foreign_key: true
      t.timestamps
    end
  end
end
