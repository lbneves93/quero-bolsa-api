class ChangeDiscountPercentageDecimalToOffers < ActiveRecord::Migration[6.1]
  def change
    change_column :offers, :discount_percentage, :decimal, precision: 5
  end
end
