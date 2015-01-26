require "rails_helper"

describe SessionsController do

  describe "#create" do
    before {
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github] 
    }
    it "logs the user in with a correct hash" do
      expect {
        post :create, provider: "github"
      }.to change { User.count }.by(1)
    end

    it "sets the users details" do
      post :create, provider: "github"
      expect(User.last.username).to eq "svend"
      expect(User.last.name).to eq "Svend"
      expect(User.last.email).to eq "svend@test.com"
    end
  end
end
