class BidsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bid, only: [:show, :edit, :update, :destroy]
  before_action :find_auction

  # GET /bids
  # GET /bids.json
  def index
    current_user
    @bids = Bid.all
  end

  # GET /bids/1
  # GET /bids/1.json
  def show
  end

  # GET /bids/new
  def new
    @bid = Bid.new
  end

  # GET /bids/1/edit
  def edit
  end

  # POST /bids
  # POST /bids.json
  def create
    @bid = Bid.new(bid_params)
    @bid.auction = @auction
    @bid.bid_date = Time.now
    @bid.user = current_user

    respond_to do |format|
      if highest_bid? && @bid.save
        @auction.current_price = @bid.offer_price
        check_and_set_reserve
        @auction.save

        format.html { redirect_to @auction, notice: 'Bid was successfully created.' }
        format.js   { render }
        format.json { render :show, status: :created, location: @bid }
      else
        format.html { render "auctions/show" }
        format.js   { render js: "alert('Can\\'t bid, please try a valid bid!');"  }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bids/1
  # DELETE /bids/1.json
  def destroy
    @bid.destroy
    respond_to do |format|
      format.html { redirect_to bids_url, notice: 'Bid was successfully destroyed.' }
      format.json { head :no_content }
      format.js   { render :destroy }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid
      @bid = Bid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bid_params
      params.require(:bid).permit(:bid_date, :offer_price, :current_price, :auction_id)
    end

    def find_auction
      @auction = Auction.find params[:auction_id]
    end

    def highest_bid?
      @bid.offer_price > @auction.current_price
    end

    def check_and_set_reserve
      if @bid.offer_price >= @auction.reserve_price
        @auction.meet_reserve
      end
    end

end
