require "json"
require "./base"
require "./user"

module Github
  module Response
    class Repositories < Base
      JSON.mapping(
        total_count: Int32,
        incomplete_results: Bool,
        items: Array(Repository)
      )
    end

    class Repository
      JSON.mapping(
        id: Int32,
        name: String,
        full_name: String,
        owner: User,
        private: Bool,
        html_url: String,
        contents_url: String,
        description: String?,
        fork: Bool,
        url: String,
        # created_at: "2012-01-01T00:31:50Z",
        # updated_at: "2013-01-05T17:58:47Z",
        # pushed_at: "2012-01-01T00:37:02Z",
        homepage: String?,
        size: Int32,
        stargazers_count: Int32,
        watchers_count: Int32,
        language: String,
        forks_count: Int32,
        open_issues_count: Int32,
        default_branch: String,
        score: Float32
      )
    end
  end
end
