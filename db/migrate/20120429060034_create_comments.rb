class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.references :user
      t.references :node
      t.string :comment_text

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :node_id
  end

  def down
    drop_table :comments
  end
end
