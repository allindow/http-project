# require "./server"
# require "socket"
require "./lib/parser"

class Response
  attr_reader :parser,
              :request_lines

  def initialize(request_lines)
    @parser = Parser.new
    @request_lines = request_lines
  end

  def date_and_time
    Time.now.strftime("%m:%M%p on %A, %B %e, %Y ")
  end

  def path_controller(client,hello_counter,counter,request_lines)
      case parser.get_path(request_lines)
    when '/'
      client.puts request_info(request_lines)
    when '/hello'
      client.puts "Hello World #{hello_counter}"
    when '/datetime'
      client.puts date_and_time
    when '/shutdown'
      client.puts "Total Requests: #{counter}"
    else
      client.puts "Check this guy out, he thinks #{parser.get_path(request_lines)} is a thing! It's not. Sorry."
    end
    client.close
  end

  def request_info(request_lines)
    output = ["<pre>Verb: #{parser.get_verb(request_lines)}",
      "Path: #{parser.get_path(request_lines)}",
      "Protocol: #{parser.get_protocol(request_lines)}",
      "Host: #{parser.get_host(request_lines)}",
      "Port: #{parser.get_port(request_lines)}",
      "Origin: #{parser.get_host(request_lines)}",
      "#{parser.get_accept(request_lines)}</pre>"]
    output
  end

end
