class UserBidsController < ApplicationController
  def index
    @bids = current_user.bids.all
  end
end
