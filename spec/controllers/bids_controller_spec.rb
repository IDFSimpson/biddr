require 'rails_helper'

RSpec.describe BidsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:auction) { FactoryGirl.create(:auction) }

  describe "#new" do
    context "without a logged in user" do
      it "redirects to sign up page" do
        get :new, auction_id: auction.id
        expect(response).to redirect_to new_user_session_path
      end
    end
    context "with signed in user" do
      before { sign_in user }
      it "renders the new template" do
        get :new, auction_id: auction.id
        expect(response).to render_template(:new)
      end

      it "assigns a new bid instance variable" do
        get :new, auction_id: auction.id
        expect(assigns(:bid)).to be_a_new(Bid)
      end
    end
  end

  describe "#create" do

    let(:auction) { FactoryGirl.create(:published_auction_with_current_price) }
    let(:bid_attributes) { FactoryGirl.attributes_for(:bid) }

    context "with valid attributes" do
      before { sign_in user }
      let(:valid_request) do
        post :create, bid: bid_attributes, auction_id: auction.id
      end
      let(:above_reserve_request) do
        post :create, bid: bid_attributes.merge(offer_price: (auction.reserve_price + 1)), auction_id: auction.id
      end

      it "allows bids that are higher than the current_price" do
        expect { valid_request }.to change { Bid.count }.by(1)
      end
      it "changes the aasm reserve reserve_met if the reserve is higher than the bid" do
        above_reserve_request
        expect(Auction.last.reserve_met?).to eq(true)
      end
    end

    context "with invalid attributes" do
      before { sign_in user }
      let(:invalid_request) { post :create, bid: FactoryGirl.attributes_for(:low_bid), auction_id: auction.id }
      it "disallows bids that are lower than the current_price" do
        expect { invalid_request }.to change { Bid.count }.by(0)
      end
    end

  end
end
