class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :username
      t.string :hashed_password
      t.string :salt
      t.date :dob
      t.string :email

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
