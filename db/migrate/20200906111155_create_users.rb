class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.integer :gender
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end