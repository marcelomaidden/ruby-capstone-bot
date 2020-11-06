class Channel

  attr_reader :id, :name, :purpose, :topic
  
  def initialize(id, name, topic, purpose)
    @id = id
    @name = name
    @purpose=purpose
    @topic = topic
  end
end