class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.belongs_to :author, null: false, foreign_key: true
      t.string :name, null: false
      t.string :description, null: false

      t.timestamps
    end
  end
end
