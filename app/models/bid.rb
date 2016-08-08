class Bid < ActiveRecord::Base
  belongs_to :auction
  belongs_to :user

  validates :offer_price, presence: true, numericality: { greater_than: 0 }
  validates :bid_date, presence: true
  validates :user, presence: true
  validates :auction, presence: true

end
