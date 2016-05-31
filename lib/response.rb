# require "./server"
# require "socket"
require "./lib/parser"

class Response

  def send_response(client,counter, request_lines)
    parser = Parser.new(request_lines)
    response = "<pre>" + request_lines.join("\n") + "</pre>"
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ["Verb: #{parser.verb}",
        "Path: #{parser.path}",
        "Protocol: #{parser.protocol}",
        "Host: #{parser.host}",
        "Port: #{parser.port}",
        "Origin: #{parser.host}",
        "#{parser.accept}"]

    client.puts headers
    client.puts "Hello World #{counter}"


    client.close
end

end
