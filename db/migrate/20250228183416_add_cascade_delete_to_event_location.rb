class AddCascadeDeleteToEventLocation < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :event_locations, :events
    add_foreign_key :event_locations, :events, on_delete: :cascade
  end
end
