# frozen_string_literal: true

class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses, id: :uuid do |t|
      t.string :name, null: false
      t.string :kind, null: false
      t.string :level, null: false
      t.string :shift, null: false
      t.timestamps
    end
  end
end
