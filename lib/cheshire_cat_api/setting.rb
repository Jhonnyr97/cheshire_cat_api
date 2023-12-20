# frozen_string_literal: true

module CheshireCatApi
  # all settings methods
  class Setting

    def initialize(client)
      @client = client
    end

    def index
      response = @client.get_request("/settings/")
      response.fetch(:settings, [])
    rescue StandardError => e
      raise Error, "Bad Response from Cheshire Cat API: #{e.message}"
    end

    def show(id)
      response = @client.get_request("/settings/#{id}/")
      response.fetch(:setting, {})
    rescue StandardError => e
      raise Error, "Bad Response from Cheshire Cat API: #{e.message}"
    end

    def create(body)
      response = @client.post_request("/settings/", body)
      response.fetch(:settings, [])
    rescue StandardError => e
      raise Error, "Bad Response from Cheshire Cat API: #{e.message}"
    end

    def update(id, body)
      response = @client.put_request("/settings/#{id}/", body)
      response.fetch(:setting, {})
    rescue StandardError => e
      raise Error, "Bad Response from Cheshire Cat API: #{e.message}"
    end

  end
end
