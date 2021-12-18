require "../spec_helper"

describe Unslash::Handler do
  it "removes trailing slash from path" do
    AppServer.new.listen do |server|
      response = HTTP::Client.get(server.uri "/path/")
      response.status_code.should eq(308)
      response.headers["Location"]?.should eq("/path")
    end
  end

  it "removes trailing slash from POST request path" do
    AppServer.new.listen do |server|
      response = HTTP::Client.post(server.uri "/path/")
      response.status_code.should eq(308)
      response.headers["Location"]?.should eq("/path")
    end
  end

  it "skips if path has no trailing slash" do
    AppServer.new.listen do |server|
      response = HTTP::Client.get(server.uri "/some-path")
      response.status_code.should eq(200)
      response.headers["Location"]?.should be_nil
    end
  end

  it "skips index path" do
    AppServer.new.listen do |server|
      response = HTTP::Client.get(server.uri)
      response.status_code.should eq(200)
      response.headers["Location"]?.should be_nil
    end
  end

  it "skips POST request if safe" do
    AppServer.new(safe: true).listen do |server|
      response = HTTP::Client.post(server.uri "/some-path/")
      response.status_code.should eq(200)
      response.headers["Location"]?.should be_nil
    end
  end
end
