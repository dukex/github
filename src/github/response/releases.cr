require "json"
require "./base"

module Github
  module Response
    class Releases < Base
      def self.from_json(input)
        Array(Release).new JSON::PullParser.new(input)
      end
    end

    class Release < Base
      JSON.mapping(
        url: String,
        html_url: String,
        assets_url: String,
        upload_url: String,
        tarball_url: String,
        zipball_url: String,
        id: Int32,
        tag_name: String,
        target_commitish: String,
        name: String,
        body: String,
        draft: Bool,
        prerelease: Bool,
        created_at: String,
        published_at: String,
        author: User,
      )
    end
  end
end
