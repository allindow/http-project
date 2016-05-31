# require "./server"
# require "socket"
require "./lib/parser"

class Response

  def send_response(client,counter, request_lines)
    parser = Parser.new(request_lines)
    response = "<pre>" + request_lines.join("\n") + "</pre>"
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ["Verb: #{parser.get_verb}",
        "Path: #{parser.get_path}",
        "Protocol: #{parser.get_protocol}",
        "Host: #{parser.get_host}",
        "Port: #{parser.get_port}",
        "Origin: #{parser.get_host}",
        "#{parser.get_accept}"]

    client.puts headers
    client.puts "Hello World #{counter}"

    client.puts request_lines.inspect
    client.close
end

end
