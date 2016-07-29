class PublishingsController < ApplicationController
  before_action :authenticate_user!

  def update
    auction = current_user.auctions.find(params[:auction_id])
    auction.publish!
    redirect_to auction_path(auction), notice: "Auction has been published!"
  end
end
