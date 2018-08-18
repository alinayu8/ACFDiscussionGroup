class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :role
      t.boolean :active

      t.timestamps
    end
  end
end
