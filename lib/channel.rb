class Channel

  attr_reader :id, :name, :purpose, :topic, :messages

  def initialize(id, name, topic, purpose)
    @id = id
    @name = name
    @purpose=purpose
    @topic = topic
    @messages = []
  end

  def add_message(message)
    @messages << message
  end
end