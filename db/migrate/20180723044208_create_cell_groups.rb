class CreateCellGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :cell_groups do |t|
      t.string :name
      t.string :gender

      t.timestamps
    end
  end
end
