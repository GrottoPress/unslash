# Unslash

**Unslash** is a *Crystal* HTTP handler that removes slashes (`/`) at the end of URLs, performing a redirect to the unslashed version of the same URL.

This, among others, improves SEO by avoiding duplicated content across the different versions of the same URL.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     unslash:
       github: GrottoPress/unslash
   ```

1. Run `shards update`

1. Require *Unslash*:

   ```crystal
   # ...
   require "unslash"
   # ...
   ```

## Usage

Pass an instance of `Unslash::Handler` to the web server. If using a web framework, this handler should be passed before the framework's route handler:

```crystal
# ...
require "http/server"
require "unslash"

server = HTTP::Server.new([
  # If `safe` is `true`, only `GET` and `HEAD` request methods
  # are handled.
  Unslash::Handler.new(status_code: 308, safe: false),
  # ...
])

server.bind_tcp("127.0.0.1", 8080)
server.listen
# ...
```

## Development

Run tests with `crystal spec`.

## Contributing

1. [Fork it](https://github.com/GrottoPress/unslash/fork)
1. Switch to the `master` branch: `git checkout master`
1. Create your feature branch: `git checkout -b my-new-feature`
1. Make your changes, updating changelog and documentation as appropriate.
1. Commit your changes: `git commit`
1. Push to the branch: `git push origin my-new-feature`
1. Submit a new *Pull Request* against the `GrottoPress:master` branch.
