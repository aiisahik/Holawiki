class CreateScenarios < ActiveRecord::Migration
  def up
    create_table :scenarios do |t|
      t.text :name
      t.text :description

      t.timestamps
    end

  end

  def down
    drop_table :scenarios
  end
end
