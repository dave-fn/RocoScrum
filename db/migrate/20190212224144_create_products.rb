class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.references :owner, foreign_key: {to_table: :users}
      t.references :project, foreign_key: true, index: true

      t.timestamps
    end
  end
end
