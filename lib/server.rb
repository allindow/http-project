require "socket"
require "./lib/response"
require "pry"

class Server
  attr_reader       :request_lines,
                    :client

  def initialize
    @tcp_server     = TCPServer.new(9292)
    @request_lines  = []
    @client         = @tcp_server.accept
  end

  def open
    loop do
      while line    = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
      response_to_client
      exit if path == "/shutdown"
      request_lines.slice!(0..-1)
    end
  end

  def path
    request_lines[0].split(" ")[1]
  end

  def response_to_client
    response      = Response.new(request_lines)
    output        = "<html><head></head><body>"+ response.path_controller + "</body></html>"
    headers       = ["http/1.1 200 ok", "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                    "server: ruby", "content-type: text/html; charset=iso-8859-1",
                    "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    client.puts headers
    client.puts output
  end
end

Server.new.open
