require "socket"
require "./lib/response"
require "pry"

class Server

  def initialize
    @response       = Response.new
    @tcp_server     = TCPServer.new(9292)
  end



  def open
    loop do
      client        = @tcp_server.accept
      request_lines = []
      while line    = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
      parser = Parser.new(request_lines)
      content_length = parser.get_content_length.to_i
      guess = client.read(content_length)
      output         = "<html><head></head><body>" + @response.path_controller(request_lines, guess) + "</body></html>"
      if parser.get_verb == "POST" && parser.get_path == "/game"
        client.puts redirect_headers(output)
      else
        client.puts headers(output)
      end
      client.puts output

      client.close
      path          = request_lines[0].split(" ")[1]
      @tcp_server.close if path == "/shutdown"
      request_lines.slice!(0..-1)
    end
  end

  def headers(output)
      ["http/1.1 200 ok",
       "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
       "server: ruby",
       "content-type: text/html; charset=iso-8859-1",
       "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def redirect_headers(output)
      ["http/1.1 302 Moved Permanently",
       "Location: http://127.0.0.1:9292/game",
       "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
       "server: ruby",
       "content-type: text/html; charset=iso-8859-1",
       "content-length: #{output.length + 5i}\r\n\r\n"].join("\r\n")
  end
end

Server.new.open
