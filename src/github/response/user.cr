require "json"
require "./base"

module Github
  module Response
    class User < Base
      JSON.mapping(
        login: String,
        id: Int32,
        avatar_url: String?,
        gravatar_id: String?,
        url: String,
        html_url: String,
        followers_url: String,
        following_url: String,
        gists_url: String,
        starred_url: String,
        subscriptions_url: String,
        organizations_url: String,
        repos_url: String,
        events_url: String,
        received_events_url: String,
        type: String,
        site_admin: Bool,
        name: String?,
        company: String?,
        blog: String?,
        location: String?,
        email: String?,
        hireable: Bool?,
        bio: String?,
        public_repos: Int32?,
        public_gists: Int32?,
        followers: Int32?,
        following: Int32?
      )
    end
  end
end
