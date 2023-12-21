require "httparty"
require_relative "setting"
require_relative "plugin"
require_relative "llm"
require_relative "memory"
require_relative "embedder"
require_relative "rabbit_hole"
require_relative "client_ws"
require_relative "http_utils"


module CheshireCatApi
  class Error < StandardError;end

  # Client httparty
  class Client
    include HTTParty
    include HttpUtils

    attr_reader :settings, :plugins, :llm, :memory, :embedder, :rabbit_hole

    def initialize(url, api_key)
      self.class.base_uri url
      self.class.headers "Authorization" => "Bearer #{api_key}"
      self.class.headers "Content-Type" => "application/json"
      @settings = Setting.new(self)
      @plugins = Plugin.new(self)
      @llm = Llm.new(self)
      @memory = Memory.new(self)
      @embedder = Embedder.new(self)
      @rabbit_hole = RabbitHole.new(self)
    end

    def home
      get_request("/")
    end

  end
end
