module CheshireCatApi
  class Plugin
    attr_reader :response
    def initialize(client)
      @client = client
    end

    def index
      @client.get_request("/plugins/")
    end

    def upload(file)
      options = {
        file: file
      }
      @response = @client.post_request("/plugins/upload/", options, multipart: true)
    end

    def upload_from_url(url)
      options = {
        url: url
      }
      @client.post_request("/plugins/upload/registry", options)
    end

    def delete(id)
      @client.delete_request("/plugins/#{id}/")
    end

    def toggle(id)
      @client.put_request("/plugins/toggle/#{id}/", {})
    end

    def show(id)
      @client.get_request("/plugins/#{id}/")
    end
  end
end
