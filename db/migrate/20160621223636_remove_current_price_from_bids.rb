class RemoveCurrentPriceFromBids < ActiveRecord::Migration
  def change
    remove_column :bids, :current_price, :float
  end
end
