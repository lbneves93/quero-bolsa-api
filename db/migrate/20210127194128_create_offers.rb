# frozen_string_literal: true

class CreateOffers < ActiveRecord::Migration[6.1]
  def change
    create_table :offers, id: :uuid do |t|
      t.references :course, type: :uuid, null: false, foreign_key: true
      t.decimal :full_price, precision: 10, scale: 2, null: false
      t.decimal :price_with_discount, precision: 10, scale: 2, null: false
      t.decimal :discount_percentage, precision: 3, scale: 2, null: false
      t.date :start_date, null: false
      t.string :enrollment_semester, null: false
      t.boolean :enabled, default: true
      t.timestamps
    end
  end
end
