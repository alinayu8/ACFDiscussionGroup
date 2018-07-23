class CreateMemberDgs < ActiveRecord::Migration[5.1]
  def change
    create_table :member_dgs do |t|
      t.boolean :attended
      t.references :member, foreign_key: true
      t.references :discussionGroup, foreign_key: true

      t.timestamps
    end
  end
end
