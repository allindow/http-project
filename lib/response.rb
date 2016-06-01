# require "./server"
# require "socket"
require "./lib/parser"

class Response
  attr_reader :parser,
              :request

  def initialize
    @parser = Parser.new
    @request = []
  end

  def date_and_time
    Time.now.strftime("%m:%M%p on %A, %B %e, %Y ")
  end


  def info(request)
    ["Verb: #{parser.get_verb(request.flatten)}",
      "Path: #{parser.get_path(request.flatten)}",
      "Protocol: #{parser.get_protocol(request.flatten)}",
      "Host: #{parser.get_host(request.flatten)}",
      "Port: #{parser.get_port(request.flatten)}",
      "Origin: #{parser.get_host(request.flatten)}",
      "#{parser.get_accept(request.flatten)}"]
  end

  def main_response
    "<pre>" + [info(request.flatten)].join("\n") + "</pre>"
  end

  def main_output(response=main_response)
    "<html><head></head><body>#{response}</body></html>"
  end

  def headers
    headers = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{main_output.length}\r\n\r\n"].join("\r\n")
      headers
  end


  def path_controller(client,hello_counter,counter,request_lines)
    request << request_lines
    case parser.get_path(request_lines)
    when '/'
      client.puts headers
      client.puts main_output
    when '/hello'
      hello_response = "<pre>" + "Hello World #{hello_counter}\n" + "</pre>"
      client.puts main_output(hello_response)
    when '/datetime'
      client.puts date_and_time
    when '/shutdown'
      client.puts "Total Requests: #{counter}"
    else
      client.puts "Check this guy out, he thinks #{parser.get_path(request_lines)} is a thing! It's not. Sorry."
    end
    client.close
    request.slice!(0..-1)
  end
end
