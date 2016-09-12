class CreateDrones < ActiveRecord::Migration[5.0]
  def change
    create_table :drones do |t|
      t.string :name
      t.string :server_address
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :drones, :name, unique: true
  end
end
