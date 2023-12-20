module CheshireCatApi
  class Plugin
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
      response = @client.get_request("/plugins/#{id}/")
      response[:data]
    end

    def settings
      response = @client.get_request("/plugins/settings/")
      response[:settings]
    end

    def setting(id)
      @client.get_request("/plugins/settings/#{id}/")
    end

    def update_setting(id, value)
      @client.put_request("/plugins/settings/#{id}/", value)
    end
  end
end
