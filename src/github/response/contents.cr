require "json"
require "./base"

module Github
  module Response
    class Contents < Base
      JSON.mapping(
        type: String,
        encoding: String,
        size: Int32,
        name: String,
        path: String,
        content: String,
        sha: String,
        url: String,
        git_url: String,
        html_url: String,
        download_url: String
      )
    end
  end
end
