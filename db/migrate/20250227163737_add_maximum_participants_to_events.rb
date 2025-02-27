class AddMaximumParticipantsToEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :maximum_participants, :integer
  end
end
