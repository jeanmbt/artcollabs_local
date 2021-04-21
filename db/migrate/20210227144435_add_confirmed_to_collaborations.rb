class AddConfirmedToCollaborations < ActiveRecord::Migration[6.0]
  def change
    add_column :collaborations, :confirmed, :boolean, default: false
  end
end
