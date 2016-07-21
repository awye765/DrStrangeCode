require 'rails_helper'

describe "GET '/auth/github/callback'" do

  before do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    successful_github_login_setup
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
  end

  it "should set user_id" do
    expect(session[:user_id]).to eq(User.last.id)
  end

end
