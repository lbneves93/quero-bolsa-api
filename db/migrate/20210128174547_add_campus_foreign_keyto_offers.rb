# frozen_string_literal: true

class AddCampusForeignKeytoOffers < ActiveRecord::Migration[6.1]
  def change
    add_reference :offers, :campus, type: :uuid, index: true, column: :campus_id, foreign_key: true
  end
end
