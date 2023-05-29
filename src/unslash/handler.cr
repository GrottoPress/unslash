class Unslash::Handler
  include HTTP::Handler

  def initialize(@status : HTTP::Status = :permanent_redirect, *, @safe = false)
  end

  def self.new(status_code, *, safe)
    new HTTP::Status.new(status_code), safe: safe
  end

  def call(context : HTTP::Server::Context) : Nil
    request, response = context.request, context.response
    path = request.path

    if path == "/" ||
      !path.ends_with?("/") ||
      @safe && !request.method.in?({"GET", "HEAD"})

      return call_next(context)
    end

    request.path = path.rchop("/")
    response.headers["Location"] = request.resource
    response.status = @status
  end
end
