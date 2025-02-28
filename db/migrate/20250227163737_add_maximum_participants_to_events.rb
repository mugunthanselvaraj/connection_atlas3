class AddMaximumParticipantsToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :maximum_participants, :integer
  end
end
