class AddDefaultValueToExerciseLevel < ActiveRecord::Migration[5.1]
  def change
    change_column :exercises, :level, :integer, default: 0
  end
end
