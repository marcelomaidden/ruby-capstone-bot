require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'date'
require 'fileutils'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
APPLICATION_NAME = 'Google Calendar API Ruby Bot'.freeze
CREDENTIALS_PATH = 'credentials.json'.freeze
# The file token.yaml stores the user's access and refresh tokens, and is
# created automatically when the authorization flow completes for the first
# time.
TOKEN_PATH = 'token.yaml'.freeze
SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY

class Calendar
  ##
  # Ensure valid credentials, either by restoring from the saved credentials
  # files or intitiating an OAuth2 authorization. If authorization is required,
  # the user's default browser will be launched to approve the request.
  #
  # @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
  def authorize
    client_id = Google::Auth::ClientId.from_file CREDENTIALS_PATH
    token_store = Google::Auth::Stores::FileTokenStore.new file: TOKEN_PATH
    authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
    user_id = 'default'
    credentials = authorizer.get_credentials user_id
    if credentials.nil?
      url = authorizer.get_authorization_url base_url: OOB_URI
      puts 'Open the following URL in the browser and enter the ' \
          "resulting code after authorization:\n" + url
      code = gets
      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: OOB_URI
      )
    end
    credentials
  end

  def initialize
    # Initialize the API
    @service = Google::Apis::CalendarV3::CalendarService.new
    @service.client_options.application_name = APPLICATION_NAME
    @service.authorization = authorize
  end

  def list
    page_token = nil
    message = ''

    loop do
      result = @service.list_calendar_lists(page_token: page_token)
      result.items.each do |e|
        message.concat("#{e.summary}\n")
        message.concat("#{fetch(e.id)}\n\n")
      end
      page_token = (result.next_page_token if result.next_page_token != page_token)
      break if page_token.nil?
    end
    message
  end

  def fetch(calendar)
    # Fetch the next 10 events for the user
    calendar_id = calendar

    result = ''
    response = @service.list_events(calendar_id,
                                    max_results: 10,
                                    single_events: true,
                                    order_by: 'startTime',
                                    time_min: DateTime.now.rfc3339)
    result.concat("Upcoming events:\n")
    result.concat("No upcoming events found\n") if response.items.empty?
    response.items.each do |event|
      start = event.start.date || event.start.date_time
      result.concat("- #{event.summary} (#{start})\n#{event.html_link}\n\n")
    end
    result
  end
end
