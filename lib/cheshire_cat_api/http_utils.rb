module CheshireCatApi
  # actions and parsers
  module HttpUtils
    def get_request(endpoint, query = {}, headers = {})
      response = self.class.get(endpoint, query: query, headers: headers)
      parse_response(response)
    end

    def put_request(endpoint, body, headers = {})
      response = self.class.put(endpoint, body: body.to_json, headers: headers)
      parse_response(response)
    end

    def post_request(endpoint, body, headers = {}, multipart: false)

      if multipart
        headers["Content-Type"] = "multipart/form-data"
      else
        body = body.to_json
        headers["Content-Type"] ||= "application/json"
      end

      response = self.class.post(endpoint, body: body, headers: headers)
      parse_response(response)
    end

    def delete_request(endpoint, headers = {})
      response = self.class.delete(endpoint, headers: headers)
      parse_response(response)
    end

    private

    def parse_response(response)
      JSON.parse(response.body, symbolize_names: true)
    rescue JSON::ParserError => e
      raise Error, "Error parser: #{e.message}"
    end
  end
end
