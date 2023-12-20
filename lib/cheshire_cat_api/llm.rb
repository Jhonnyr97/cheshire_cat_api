module CheshireCatApi
  class Llm
    def initialize(client)
      @client = client
    end

    def settings
      response = @client.get_request("/llm/settings/")
      response[:settings]
    end

    def setting(id)
      @client.get_request("/llm/settings/#{id}/")
    end

    def update(id, value)
      @client.put_request("/llm/settings/#{id}/", options = {})
    end
  end
end
