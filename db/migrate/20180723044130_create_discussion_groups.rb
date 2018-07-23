class CreateDiscussionGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :discussion_groups do |t|
      t.string :name
      t.references :largeGroup, foreign_key: true

      t.timestamps
    end
  end
end
