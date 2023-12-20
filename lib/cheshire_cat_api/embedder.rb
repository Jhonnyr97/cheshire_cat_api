module CheshireCatApi
  class Embedder
    def initialize(client)
      @client = client
    end

    def settings
      response = @client.get_request("/embedder/settings/")
      response[:settings]
    end

    def setting(id)
      @client.get_request("/embedder/settings/#{id}/")
    end

    def update(id, options = {})
      @client.put_request("/embedder/settings/#{id}/", options)
    end
  end
end
