class CreateTimedBlocks < ActiveRecord::Migration[5.1]
  def change
    create_table :timed_blocks do |t|
      t.references :user, foreign_key: true
      t.references :exercise, foreign_key: true
      t.datetime :expiration
      t.integer :type

      t.timestamps
    end
  end
end
