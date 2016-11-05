# github

Crystal toolkit for the GitHub API

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  github:
    github: dukex/github
```


## Usage


```crystal
require "github"
```

First of all create a client

```crystal
client = Github::Client.new access_token: "YOUR-GITHUB-TOKEN"
```

### Search

You can make an search to any path described on [github documentation](https://developer.github.com/v3/search) with `search` method, but just the repositories search using `repositories` method will be mapped to an object, the search method returns a HTTP::Response

Example:

```
client.search('/code', {"q" => "language:crystal"})
client.search('/issues', {"q" => "type:closed"})
client.search('/users', {"q" => "type:org"})
client.search('/repositories', {"q" => "language:crystal"})
```

#### Repositories

To search repository you can use `Client#repositories`, the `repositories` method accepts the following params:

| Name | Type  | Description |
|------|-------|-------------|
| q | string | The search keywords, as well as any qualifiers. |
| sort | string | The sort field. One of stars, forks, or updated. Default: results are sorted by best match. |
| order | string | The sort order if sort parameter is provided. One of asc or desc. Default: desc |

To understand more about this params see [github documentation](https://developer.github.com/v3/search/#search-repositories)


Example:

```crystal
client.repositories({"q" => "language:crystal", "sort" => "stars", "asc"})
=> Github::Response::Repositories
```

### Contents

#### Readme

Github have a shortcut to get contents of 'readme' file

```crystal
# repository is a Github::Response::Repository
readme = client.readme(repository)
=> Github::Response::Contents
readme.content
=> "Just another Readme"
```

#### Content

To get some repository content you can use `content` method

Example:

```crystal
main_file = client.content(repository, 'main.c')
=> Github::Response::Contents
```

### Users

To get an user, just use `user` method, when the username params are ommited will returns the current authenticated user

```crystal
myself = client.user('dukex')
=> Github::Response::User
me = client.user
=> Github::Response::User
```

### Releases

List releases for a repository using `releases` methods

```crystal
myself = client.releases('rails', 'rails')
=> Github::Response::Releases
```

## Contributing

1. Fork it ( https://github.com/dukex/github/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [dukex](https://github.com/dukex) Duke - creator, maintainer
