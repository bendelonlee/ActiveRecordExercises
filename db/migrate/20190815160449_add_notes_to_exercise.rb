class AddNotesToExercise < ActiveRecord::Migration[5.1]
  def change
    add_column :exercises, :notes, :text
  end
end
