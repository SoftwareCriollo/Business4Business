require 'rails_helper'
require 'stripe_mock'

describe ChargesController do
  company_login

  describe "POST create" do
    let(:stripe) { StripeMock.create_test_helper }
    let(:stripe_error) { StripeMock.prepare_card_error(:card_declined) }
    before { StripeMock.start }
    after { StripeMock.stop }

    it "responds with a 200 HTTP status code" do
      post :create, stripeToken: stripe.generate_card_token, format: :json
      expect(response).to have_http_status(:ok)
    end

    it "responds with error card declined" do
      post :create, stripeToken: stripe_error, format: :json
      expect(JSON.parse(response.body)["message"]).to eq('The card was declined')
    end

  end
end