require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do
  describe "#new" do
    let(:auction) { FactoryGirl.create(:auction) }
    before {get :new}
    it "renders the new template" do
      expect(response).to render_template(:new)
    end

    it "assigns a new auction instance variable" do
      expect(assigns(:auction)).to be_a_new(Auction)
    end
  end

  describe "#create" do
    describe "with valid attributes" do
      let(:valid_request) { post :create, auction: FactoryGirl.attributes_for(:auction) }

      it "saves a record to the database" do
        expect { valid_request }.to change{ Auction.count }.by(1)
      end

      it "redirects to the auction listing" do
        valid_request
        expect(response).to redirect_to(auction_path(Auction.last))
      end
    end
  end
end
