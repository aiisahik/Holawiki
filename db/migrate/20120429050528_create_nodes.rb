class CreateNodes < ActiveRecord::Migration
  def up
    create_table :nodes do |t|
      t.references :user
      t.integer :node_type
      t.references :speaker
      t.string :node_text
      t.integer :previous_node_id
      t.references :scenario
      t.timestamps
    end
    add_index :nodes, :user_id
    add_index :nodes, :previous_node_id
    add_index :nodes, :scenario_id
    add_index :nodes, :speaker_id
  end

  def down
    drop_table :nodes
  end
end
