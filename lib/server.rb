require "socket"
require "./lib/response"
# require "./lib/parser"
require "pry"

class Server

  def initialize
    @response = Response.new
    @tcp_server = TCPServer.new(9292)
    # @request_lines = []
  end


  def open
    # hello_counter = -1
    # counter = 0
    loop do
      # counter += 1
      client = @tcp_server.accept
      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
        # if request_lines[0].split(" ")[1] == "/hello"
        #    hello_counter +=1
        # end
        output = @response.path_controller(request_lines)
        headers = ["http/1.1 200 ok",
                  "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                  "server: ruby",
                  "content-type: text/html; charset=iso-8859-1",
                  "content-length: #{output.length}\r\n\r\n"].join("\r\n")

      client.puts headers
      client.puts output
      client.close
      exit if request_lines[0].split(" ")[1] == "/shutdown"
      request_lines.slice!(0..-1)
    end
  end
end

Server.new.open
# if __FILE__ == $PROGRAM_NAME
#  server = Server.new
# end
