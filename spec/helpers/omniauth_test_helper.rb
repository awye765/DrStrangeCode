module OmniAuthTestHelper
  def successful_github_login_setup
    OmniAuth.config.test_mode = true
    # Turns on "test mode" for Omniauth.  All requests to Omniauth in testing will
    # be short circuited to use the mock authentication hash described below.

    omniauth_hash = {
      provider: 'github',
      uid: '12345',
      info: {
        email: 'info@gmail.com',
        user_name: 'Test User'
      }
    }
    # Sets up a mock omniauth_hash for a mock github login

    OmniAuth.config.add_mock(:github, omniauth_hash)
    # Creates the mock for github login using the hash details above.
  end

  def unsuccessful_github_login_setup
    OmniAuth.config.on_failure = Proc.new { |env|
      OmniAuth::FailureEndpoint.new(env).redirect_to_failure
    }
    # Mocks an unsuccessful github login with omniauth.
  end
end
