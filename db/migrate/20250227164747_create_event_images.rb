class CreateEventImages < ActiveRecord::Migration[7.1]
  def change
    create_table :event_images do |t|
      t.references :event, null: false, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
