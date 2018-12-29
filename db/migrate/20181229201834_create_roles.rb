class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :name
      t.string :description
      t.integer :min_participants
      t.integer :max_participants

      t.timestamps
    end
  end
end
