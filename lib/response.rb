# require "./server"
# require "socket"
require "./lib/parser"

class Response
  attr_reader :parser

  def initialize
    @parser = Parser.new
  end

  # def user_path(path)
  #   case path
  #   when parser.get_path == '/'
  #     send_response
  #   else
  #     "Hello"
  #   end
  # end
  def date_and_time
    Time.now.strftime("%m:%M%p on %A, %B %e, %Y ")
  end

  def send_response(client,hello_counter,counter,request_lines)
    response = "<pre>" + request_lines.join("\n") + "</pre>"
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ["Verb: #{parser.get_verb(request_lines)}",
      "Path: #{parser.get_path(request_lines)}",
      "Protocol: #{parser.get_protocol(request_lines)}",
      "Host: #{parser.get_host(request_lines)}",
      "Port: #{parser.get_port(request_lines)}",
      "Origin: #{parser.get_host(request_lines)}",
      "#{parser.get_accept(request_lines)}"]
      case
      when parser.get_path(request_lines) == '/'
        client.puts headers
      when parser.get_path(request_lines) == '/hello'
        client.puts "Hello World #{hello_counter}"
      when parser.get_path(request_lines) == '/datetime'
        client.puts date_and_time
      when parser.get_path(request_lines) == '/shutdown'
        client.puts "Total Requests: #{counter}"
        
      else
        client.puts "Check this guy out, he thinks #{parser.get_path(request_lines)} is a thing! It's not. Sorry."
      end
      client.close
    end

  end
