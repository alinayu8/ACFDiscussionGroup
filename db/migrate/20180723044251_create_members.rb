class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.string :name
      t.string :gender
      t.boolean :is_leader, default: false
      t.references :cellGroup, foreign_key: true

      t.timestamps
    end
  end
end
