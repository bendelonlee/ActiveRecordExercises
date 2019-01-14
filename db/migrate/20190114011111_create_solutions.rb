class CreateSolutions < ActiveRecord::Migration[5.1]
  def change
    create_table :solutions do |t|
      t.text :solution_code
      t.references :exercise, foreign_key: true
    end
  end
end
