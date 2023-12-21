module CheshireCatApi
  class RabbitHole
    def initialize(client)
      @client = client
    end

    def update(file, chunk_size = 400, chunk_overlap = 100)
      options = {
        file: file,
        chunk_size: chunk_size,
        chunk_overlap: chunk_overlap
      }
      @client.post_request("/rabbit_hole/", options)
    end

    def url(url, chunk_size = 400, chunk_overlap = 100)
      options = {
        url: url,
        chunk_size: chunk_size,
        chunk_overlap: chunk_overlap
      }
      @client.post_request("/rabbit_hole/web/", options)
    end

    def memory(file)
      options = {
        file: file
      }
      @client.post_request("/rabbit_hole/memory/", options)
    end

    def allowed_mimetypes
      response = @client.get_request("/rabbit_hole/allowed_mimetypes/")
      response[:allowed]
    end
  end
end
