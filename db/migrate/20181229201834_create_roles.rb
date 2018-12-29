class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.integer :min_participants, null: false, default: 1
      t.integer :max_participants, null: false, default: 1

      t.timestamps
    end
  end
end
