require "../response/contents"

module Github
  class Client
    module Contents
      def readme(repo)
        contents repo, "readme"
      end

      def content(repo, path)
        Response::Contents.from_response get(repo.contents_url.gsub("{+path}", path))
      end
    end
  end
end
