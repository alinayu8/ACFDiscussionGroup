class CreateLargeGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :large_groups do |t|
      t.date :date
      t.integer :session_number
      t.string :semester

      t.timestamps
    end
  end
end
