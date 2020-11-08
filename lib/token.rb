module Auth
  def self.show_token
    @token = ENV['BOT_USER_OAUTH_ACCESS_TOKEN']
    @token
  end
end
