class CreateSpeakers < ActiveRecord::Migration
  def up
    create_table :speakers do |t|
      t.references :scenario
      t.string :name
      t.integer :speaker_type

      t.timestamps
    end
    add_index :speakers, :scenario_id
  end

  def down
    drop_table :speakers
  end
end
