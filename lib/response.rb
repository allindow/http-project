require "./lib/parser"

class Response
  attr_reader :request_counter,
              :hello_counter

  def initialize
    @request_counter = 0
    @hello_counter = -1
  end

  def formatter(response)
    "<html><head></head><body>" + response + "</body></html>"
  end

  def path_controller(request_lines)
    @request_counter += 1
    path = request_lines[0].split(" ")[1]
    word = path.split(/\W+/)[-1]
    case path
    when '/'
      formatter("<pre>" + main_output(request_lines).join("\n") + "</pre>")
    when '/hello'
      @hello_counter += 1
      formatter("Hello World #{hello_counter}\n")
    when '/datetime'
      formatter(date_and_time)
    when '/shutdown'
      formatter("Total Requests: #{request_counter}")
    when "/word_search?word=#{word}"
      word_exists?(request_lines)
    else
      formatter("Nothing to see here. Take the blue pill & return to the Matrix.")
    end
  end


  def word_exists?(request_lines)
    word = Parser.new(request_lines).get_word_parameter << "\n"
    dictionary = IO.readlines("/usr/share/dict/words")
    if dictionary.include? word
      formatter("#{word.upcase} is a known word.")
    else
      formatter("#{word.upcase} is not a known word.")
    end
  end

  def date_and_time
    Time.now.strftime("%m:%M%p on %A, %B %e, %Y ")
  end

  def main_output(request_lines)
    Parser.new(request_lines).info
  end
end
