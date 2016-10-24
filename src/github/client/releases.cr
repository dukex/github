require "../response/releases"

module Github
  class Client
    module Releases
      def releases(owner, repo)
        Response::Releases.from_response get "/repos/#{owner}/#{repo}/releases"
      end
    end
  end
end
