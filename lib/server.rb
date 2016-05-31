require "socket"
require "./lib/response"
# require "./lib/parser"
require "pry"

class Server

  def initialize
    @response = Response.new
    @tcp_server = TCPServer.new(9292)
  end

  def open
    hello_counter = -1
    counter = 0
    loop do
      request_lines = []
      counter += 1
      client = @tcp_server.accept

      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
      if request_lines[0].split(" ")[1] == "/hello"
        hello_counter +=1
      end

      @response.send_response(client,hello_counter, counter, request_lines)
      exit if request_lines[0].split(" ")[1] == "/shutdown"
    end
  end
end

Server.new.open
