class CreateEnrollments < ActiveRecord::Migration[5.1]
  def change
    create_table :enrollments do |t|
      t.references :student, foreign_key: true
      t.references :course, foreign_key: true
      t.integer :grade
    end
  end
end
