require 'faye/websocket'
require 'eventmachine'
require 'json'

module CheshireCatApi
  class ClientWs
    attr_accessor :logs

    def initialize(url:, user: nil, callback:, logs: nil )
      @url = url
      @user = user
      @message = callback
      @open = false
      @queue = []
      @logs = logs
      establish_connection
    end

    def send_message(text)
      @queue << text
      loop do
        break unless @queue.size > 0

        @connection.send({ text: @queue.shift.to_json }.to_json) if @open
      end
    end

    def close
      @connection.close if @connection
      @open = false
    end

    private

    def establish_connection
      @thread = Thread.new { EM.run { setup_websocket } }
    end

    def setup_websocket
      @connection = Faye::WebSocket::Client.new(build_ws_url)
      bind_events
    end

    def bind_events
      @connection.on(:open)    { |event| handle_open(event) }
      @connection.on(:message) { |event| handle_message(event) }
      @connection.on(:close)   { |event| handle_close(event) }
    end

    def build_ws_url
      url = "ws://#{@url}/ws/"
      url += "#{@user}" if @user
      url
    end

    def handle_open(event)
      log_event(:open)
      @open = true
    end

    def handle_message(event)
      @message.call(event) if @message
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
