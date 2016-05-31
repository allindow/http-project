# require "./server"
# require "socket"
# require "./parser"

class Response

  def send_response(client,counter, request_lines)
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

end
