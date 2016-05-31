require "socket"
require "./lib/response"
# require "./lib/parser"
require "pry"

class Server
attr_reader :request_lines

  def initialize
    @response = Response.new(request_lines)
    @tcp_server = TCPServer.new(9292)
    @request_lines = []
  end

  def open
    hello_counter = -1
    counter = 0
    loop do
      counter += 1
      client = @tcp_server.accept
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
        if request_lines[0].split(" ")[1] == "/hello"
           hello_counter +=1
        end
      @response.path_controller(client,hello_counter, counter, request_lines)
      exit if request_lines[0].split(" ")[1] == "/shutdown"
      request_lines.slice!(0..-1)
    end
  end
end

Server.new.open
