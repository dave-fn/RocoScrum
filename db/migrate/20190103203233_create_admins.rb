class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.references :user, foreign_key: true, index: {unique: true}
      t.datetime :last_logged_at

      t.timestamps
    end
  end
end
