require 'faye/websocket'
require 'eventmachine'
require 'json'

module CheshireCatApi
  class ClientWs
    attr_accessor :logs, :callback

    def initialize(url:, user: nil, callback:nil , logs: nil, protocols: nil, options: nil)
      @url = url
      @user = user
      @callback = callback
      @open = false
      @queue = []
      @logs = logs
      @protocols = protocols
      @options = options
    end

    def send_message(text)
      @queue << text
      loop do
        break unless @queue.size > 0

        @connection.send({ text: @queue.shift.to_json }.to_json) if @open
      end
    end

    def close
      @open = false
      @connection.close if @connection
    end

    def connect(message: nil)
      @thread = Thread.new { EM.run { setup_websocket } }
      send_message(message) if message
    end

    private

    def setup_websocket
      @connection = Faye::WebSocket::Client.new(build_ws_url, @protocols, @options)
      bind_events
    end

    def bind_events
      @connection.on(:open)    { |event| handle_open(event) }
      @connection.on(:message) { |event| handle_message(event) }
      @connection.on(:close)   { |event| handle_close(event) }
    end

    def build_ws_url
      url = "ws://#{@url}/ws"
      url += "/#{@user}" if @user
      url
    end

    def handle_open(event)
      log_event(:open)
      @open = true
    end

    def handle_message(event)
      @callback.call(event) if @callback
    end

    def handle_close(event)
      log_event(:close, event.code, event.reason)
    end

    def log_event(*args)
      return @logs.call(args) if @logs

      puts args
    end

    def log_error(error)
      return @logs.call(error) if @logs

      puts "Error: #{error.message}"
    end
  end
end
