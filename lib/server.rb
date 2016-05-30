require 'socket'
tcp_server = TCPServer.new(9292)
client = tcp_server.accept

puts "Ready for a request"
request_lines = []
while line = client.gets and !line.chomp.empty?
  request_lines << line.chomp
end

puts "Sending response."
response = "<pre>" + "Hello World(#{request_lines.count})" + "</pre>"
output = "<html><head></head><body>#{response}</body></html>"
headers = ["http/1.1 200 ok",
          "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
          "server: ruby",
          "content-type: text/html; charset=iso-8859-1",
          "content-length: #{output.length}\r\n\r\n"].join("\r\n")
client.puts headers
client.puts output


# require 'socket'
#
# class Server
#
#   def initialize
#     @tcp_server = TCPServer.new(9292)
#     @client = tcp_server.accept
#   end
# end
