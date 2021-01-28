class CreateCampusCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :campus_courses, id: :uuid do |t|
      t.belongs_to :campus, type: :uuid, index: true
      t.belongs_to :course, type: :uuid, index: true
      t.timestamps
    end
  end
end
