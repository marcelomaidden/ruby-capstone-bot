module Auth
  def show_token
    @token = ENV["BOT_USER_OAUTH_ACCESS_TOKEN"]
    return @token
  end
end
