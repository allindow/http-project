require "./lib/parser"

class Response
  attr_reader :request_counter,
              :hello_counter

  def initialize
    @request_counter = 0
    @hello_counter = -1
  end

  def formatter(response)
    "<html><head></head><body><pre>" + response + "</pre></body></html>"
  end

  def path_controller(request_lines)
    @request_counter += 1
    case request_lines[0].split(" ")[1]
    when '/'
      formatter(main_output(request_lines).join("\n"))
    when '/hello'
      @hello_counter += 1
      formatter("Hello World #{hello_counter}\n")
    when '/datetime'
      formatter(date_and_time)
    when '/shutdown'
      formatter("Total Requests: #{request_counter}")
    else
      formatter("Nothing to see here. Take the blue pill & return to the Matrix.")
    end
  end

  def date_and_time
    Time.now.strftime("%m:%M%p on %A, %B %e, %Y ")
  end

  def main_output(request_lines)
    Parser.new(request_lines).info
  end
end
