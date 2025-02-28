class AddCascadeDeleteToEventLocation < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :event_locations, :events
    add_foreign_key :event_locations, :events, on_delete: :cascade
  end
end
