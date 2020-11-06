Requirements

  - Add workspace to Slack
  - Create app on api.slack in your new workspace
  - Add features and functionalities
    - Bots
    - Permissions
  - Install your app to your workspace
    - Create Bot Oauth Permissions
      - Scopes
        - channels:history
        - channels:read
        - chat:write
        - chat:write.public
        - groups:history
        - im:history
        - mpim:history

set token on linux system

  export BOT_USER_OAUTH_ACCESS_TOKEN='string_token_from_bot_oauth_slack'

command to start program


  BOT_USER_OAUTH_ACCESS_TOKEN=BOT_USER_OAUTH_ACCESS_TOKEN ruby bin/run.rb 

