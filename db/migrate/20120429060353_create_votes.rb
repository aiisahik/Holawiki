class CreateVotes < ActiveRecord::Migration
  def up
    create_table :votes do |t|
      t.integer :vote
      t.references :user
      t.references :node

      t.timestamps
    end
    add_index :votes, :user_id
    add_index :votes, :node_id
  end

  def down
    drop_table :votes
  end
end
