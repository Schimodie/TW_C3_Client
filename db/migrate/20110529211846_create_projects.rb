class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :urlId
      t.integer :clicks

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
