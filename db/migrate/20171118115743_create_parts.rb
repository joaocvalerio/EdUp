class CreateParts < ActiveRecord::Migration[5.1]
  def change
    create_table :parts do |t|
      t.string :description
      t.references :course, foreign_key: true
      t.string :video

      t.timestamps
    end
  end
end
