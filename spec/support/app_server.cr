struct AppServer
  private HOST = "127.0.0.1"
  private PORT = 5000

  def initialize(*, safe = false)
    handler = Unslash::Handler.new(308, safe: safe)

    @server = HTTP::Server.new([handler]) do |context|
      context.response.content_type = "text/plain"
      context.response.print "Hello, World!"
    end
  end

  def listen
    @server.bind_tcp(HOST, PORT, reuse_port: true)
    @server.listen
  end

  def listen
    listen_async
    yield self
    close
  end

  def listen_async
    spawn { listen }

    until @server.listening?
      Fiber.yield
    end
  end

  def close
    @server.close
  end

  def uri(path = "/")
    "http://#{HOST}:#{PORT}/#{path.lchop("/")}"
  end
end
