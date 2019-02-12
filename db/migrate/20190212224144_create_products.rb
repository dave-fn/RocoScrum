class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.references :owner, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
