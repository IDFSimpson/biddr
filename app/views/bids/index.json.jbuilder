json.array!(@bids) do |bid|
  json.extract! bid, :id, :bid_date, :offer_price, :current_price, :auction_id
  json.url bid_url(bid, format: :json)
end
