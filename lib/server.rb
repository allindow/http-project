require 'socket'
require "./response"
require "./parser"
tcp_server = TCPServer.new(9292)
counter = 0
loop do
  counter += 1
client = tcp_server.accept

request_lines = []

while line = client.gets and !line.chomp.empty?
  request_lines << line.chomp
end


response = "<pre>" + request_lines.join("\n") + "</pre>"
output = "<html><head></head><body>#{response}</body></html>"
headers = ["Verb: POST",
          "Path: /",
          "Protocol: HTTP/1.1",
          "#{request_lines[0]}",
          "Port: 9292",
          "Origin: 127.0.0.1",
          "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"]


client.puts headers
client.puts "Hello World #{counter}"

client.close

end
