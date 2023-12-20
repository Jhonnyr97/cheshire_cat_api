require "httparty"
require_relative "setting"
require_relative "plugin"
require_relative "http_utils"


module CheshireCatApi
  class Error < StandardError
    attr_reader :response

    def initialize(response)
      @response = response
      super(response.body)
    end
  end

  # Client httparty
  class Client
    include HTTParty
    include HttpUtils

    attr_reader :settings, :plugins

    def initialize(url, api_key)
      self.class.base_uri url
      self.class.headers "Authorization" => "Bearer #{api_key}"
      self.class.headers "Content-Type" => "application/json"
      @settings = Setting.new(self)
      @plugins = Plugin.new(self)
    end

    def home
      get_request("/")
    end

  end
end
