# frozen_string_literal: true

class CreateCampus < ActiveRecord::Migration[6.1]
  def change
    create_table :campus, id: :uuid do |t|
      t.references :university, type: :uuid, null: false, foreign_key: true
      t.string :name, null: false
      t.string :city, null: false
      t.timestamps
    end
  end
end
