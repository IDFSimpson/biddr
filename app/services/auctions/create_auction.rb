class Auctions::CreateAuction
  include Virtus.model

  attribute :user,    User
  attribute :params,  Hash
  attribute :auction, Auction

  def call
    @auction = Auction.new(params)
    @auction.current_price = 0
    @auction.user = user
    @auction.save
  end
end
