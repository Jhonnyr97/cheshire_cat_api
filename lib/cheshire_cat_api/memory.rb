module CheshireCatApi
  class Memory
    def initialize(client)
      @client = client
    end

    def recall(query, k: 100)
      options = { text: query, k: k }
      @client.get_request("/memory/recall/", options)
    end

    def collections
      response = @client.get_request("/memory/collections/")
      response[:collections]
    end

    def delete_collections
      response = @client.delete_request("/memory/collections/")
      response[:deleted]
    end

    def delete_collection(collection)
      response = @client.delete_request("/memory/collections/#{collection}/")
      response[:deleted]
    end

    def delete_point(collection, point)
      response = @client.delete_request("/memory/collections/#{collection}/points/#{point}/")
      response[:deleted]
    end

    def delete_points(collection)
      response = @client.delete_request("/memory/collections/#{collection}/")
      response[:deleted]
    end

    def conversations
      response = @client.get_request("/memory/conversation_history/")
      response[:history]
    end

    def delete_conversations
      response = @client.delete_request("/memory/conversation_history/")
      response[:deleted]
    end


  end
end
