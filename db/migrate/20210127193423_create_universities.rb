# frozen_string_literal: true

class CreateUniversities < ActiveRecord::Migration[6.1]
  def change
    create_table :universities, id: :uuid do |t|
      t.string :name, null: false
      t.decimal :score, precision: 10, scale: 2, null: false
      t.string :logo_url
      t.timestamps
    end
  end
end
