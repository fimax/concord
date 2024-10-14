class CreateCompetences < ActiveRecord::Migration[6.1]
  def change
    create_table :competences do |t|
      t.string :name, null: false

      t.timestamps
    end

    create_table :course_competences do |t|
      t.belongs_to :course, null: false, foreign_key: true
      t.belongs_to :competence, null: false, foreign_key: true

      t.timestamps
    end

    add_index :course_competences, [:course_id, :competence_id], unique: true
  end
end
