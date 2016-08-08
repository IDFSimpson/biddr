class PublishingsController < ApplicationController
  before_action :authenticate_user!

  def update
    auction = current_user.auctions.find(params[:auction_id])
    service = Auctions::PublishAuction.new(auction: auction)
    if service.call
      redirect_to service.auction, notice: "Auction has been published!"
    else
      redirect_to service.auction, alert: "Auction has not been published"
    end
  end
end
