class CreateAdmins < ActiveRecord::Migration[8.0]
  def change
    create_table :admins do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone
      t.integer :role_level, default: 0
      t.boolean :active_status, default: true
      t.timestamps
    end

    add_index :admins, :email, unique: true

    add_index :admins, :name
  end
end
