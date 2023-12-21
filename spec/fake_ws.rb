class FakeWs
  attr_accessor :socket, :messages

  def initialize
    @messages = []
  end

  def call(env)
    if Faye::WebSocket.websocket?(env)
      self.socket = Faye::WebSocket.new(env)

      socket.on :message do |event|
        @messages << event.data
        socket.send(event.data)
      end

      socket.rack_response
    else
      [200, {'Content-Type' => 'text/plain'}, ['Hello']]
    end
  end

  def has_message?(message)
    messages.include? message
  end
end
