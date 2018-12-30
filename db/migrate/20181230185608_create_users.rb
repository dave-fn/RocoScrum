class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.datetime :last_logged_at

      t.timestamps
    end
    add_index :users, :email
  end
end
