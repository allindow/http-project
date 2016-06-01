# require "./server"
# require "socket"
require "./lib/parser"

class Response
  attr_reader :counter,
              :hello_counter

  def initialize
    # @parser = Parser.new
    @counter = 0
    @hello_counter = -1
    # @request = []
  end


  #
  # def info(request)
  #   ["Verb: #{parser.get_verb(request.flatten)}",
  #     "Path: #{parser.get_path(request.flatten)}",
  #     "Protocol: #{parser.get_protocol(request.flatten)}",
  #     "Host: #{parser.get_host(request.flatten)}",
  #     "Port: #{parser.get_port(request.flatten)}",
  #     "Origin: #{parser.get_host(request.flatten)}",
  #     "#{parser.get_accept(request.flatten)}"]
  # end


  # def main_output(response=main_response)
  #   "<html><head></head><body>#{response}</body></html>"
  # end

  # def headers
  #   headers = ["http/1.1 200 ok",
  #             "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
  #             "server: ruby",
  #             "content-type: text/html; charset=iso-8859-1",
  #             "content-length: #{main_output.length}\r\n\r\n"].join("\r\n")
  #     headers
  # end
  def formatter(response)
    "<html><head></head><body><pre>" + response + "</pre></body></html>"
  end
  def path_controller(request_lines)
    # request << request_lines
    @counter += 1
    case request_lines[0].split(" ")[1]
    when '/'
      # formatter(main_output(request_lines).join("\n"))
      "<html><head></head><body><pre>" +main_output(request_lines).join("\n") + "</pre></body></html>"
      # client.puts headers
      # client.puts main_output
    when '/hello'
      @hello_counter += 1
        "<html><head></head><body>"+"Hello World #{hello_counter}\n" + "</body></html>"
      # client.puts main_output(hello_response)
    when '/datetime'
      # client.puts
      "<html><head></head><body>"+ date_and_time + "</body></html>"
    when '/shutdown'
      # client.puts
      "<html><head></head><body>" + "Total Requests: #{counter}" + "</body></html>"
    else
      # client.puts
      "<html><head></head><body>" + "Check this guy out, he thinks #{request_lines[0].split(" ")[1]} is a thing! It's not. Sorry." + "</body></html>"
    end
  end

  def date_and_time
    Time.now.strftime("%m:%M%p on %A, %B %e, %Y ")
  end

  def main_output(request_lines)
    Parser.new(request_lines).info
  end
end

  # def main_response
  #   "<pre>" + [info(request.flatten)].join("\n") + "</pre>"
  # end
