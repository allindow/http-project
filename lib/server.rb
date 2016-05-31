require "socket"
require "./lib/response"
# require "./lib/parser"
require "pry"

class Server


  def initialize
    @response = Response.new
    @tcp_server = TCPServer.new(9292)
    # @parser = Parser.new
  end

  def open
    counter = 0
    loop do
      counter += 1
      client = @tcp_server.accept
      request_lines = []

      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end

      @response.send_response(client,counter, request_lines)
    end
  end
end

Server.new.open
