class Conversation
  attr_reader :type, :subtype, :time_stamp, :user, :text

  def initialize(type, subtype, time_stamp, user, text)
    @type = type
    @subtype = subtype
    @time_stamp = time_stamp
    @user = user
    @text = text
  end
end
