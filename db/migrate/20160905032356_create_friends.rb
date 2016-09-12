class CreateFriends < ActiveRecord::Migration[5.0]
  def change
    create_table :friends do |t|
      t.string :phone_number
      t.string :email
      t.references :user, foreign_key: true
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
