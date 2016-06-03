# require "./lib/parser"
# require "./lib/word_search.rb"

 # class Response
  attr_reader        :request_counter,
                     :hello_counter

  def initialize
    @request_counter = 0
    @hello_counter   = -1
  end


  def path_controller(request_lines)
    @request_counter += 1

    path             = request_lines[0].split(" ")[1]
    find_path(path, request_lines)
  #   word             = path.split(/\W+/)[-1]
  #   case path
  #   when '/'
  #     "<pre>" + main_output(request_lines).join("\n") + "</pre>"
  #   when '/hello'
  #     @hello_counter += 1
  #     "Hello World #{hello_counter}\n"
  #   when '/datetime'
  #     date_and_time
  #   when '/shutdown'
  #     "Total Requests: #{request_counter}"
  #   when "/word_search?word=#{word}"
  #     word_search = WordSearch.new(word)
  #     word_search.result
  #   else
  #     "Nothing to see here. Take the blue pill & return to the Matrix."
  #   end
  end

  def find_path(path, request_lines = nil)
    return path_options(request_lines)[path] if path_options(request_lines).key?(path)
    "Nothing to see here. Take the blue pill & return to the Matrix."
  end

  def path_options(request_lines)
    {"/" => debugger(request_lines),
    "/hello" => hello, "/datetime" => date_and_time,
    "/shutdown" => shutdown,
    "/word_search" => word_search_result(request_lines)}

  end

  def debugger(request_lines)
    "<pre>" + main_output(request_lines).join("\n") + "</pre>"
  end

  def hello
    @hello_counter += 1
    "Hello World #{hello_counter}\n"
  end

  def date_and_time
    Time.now.strftime("%m:%M%p on %A, %B %e, %Y ")
  end

  def word_search_result(request_lines)
    path             = request_lines[0].split(" ")[1]
    word             = path.split(/\W+/)[-1]
    word_search = WordSearch.new(word)
    word_search.result
  end

  def shutdown
    "Total Requests: #{request_counter}"
  end

  def main_output(request_lines)
    Parser.new(request_lines).info
  end

end
