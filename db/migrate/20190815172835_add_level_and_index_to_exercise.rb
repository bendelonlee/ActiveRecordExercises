class AddLevelAndIndexToExercise < ActiveRecord::Migration[5.1]
  def change
    add_column :exercises, :index, :integer
    add_column :exercises, :level, :integer    
  end
end
