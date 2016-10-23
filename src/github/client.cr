require "http/client"
require "./client/search"
require "./client/contents"
require "./client/users"

module Github
  class Client
    ENDPOINT = "api.github.com"

    include Search
    include Contents
    include Users

    @access_token : String?

    getter :access_token

    def initialize(@access_token = nil)
    end

    def get(path)
      get(path, Hash(String, String).new)
    end

    def get(path, params : Hash(String, String))
      puts "+> GET #{path} #{params}"
      path += "?" + encode_params(params) if params.size > 0
      http.get(path)
    end

    private def http
      http = HTTP::Client.new(ENDPOINT, 443, true)
      http.before_request do |request|
        request.headers["Accept"] = "application/vnd.github.v3+json"
        request.headers["Authorization"] = "token #{access_token}" if access_token
      end
      http
    end

    private def encode_params(params)
      params.map do |k, v|
        "#{k}=#{v}"
      end.join("&")
    end
  end
end
