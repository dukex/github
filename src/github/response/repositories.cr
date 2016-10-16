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
        created_at: {type: Time, converter: Time::Format.new("%F")},
        updated_at: {type: Time, converter: Time::Format.new("%F")},
        pushed_at: {type: Time, converter: Time::Format.new("%F")},
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
