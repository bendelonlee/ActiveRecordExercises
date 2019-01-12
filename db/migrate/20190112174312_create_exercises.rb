class CreateExercises < ActiveRecord::Migration[5.1]
  def change
    create_table :exercises do |t|
      t.text :instruction
      t.text :solution
      t.string :name

      t.timestamps
    end
  end
end
