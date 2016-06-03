require './lib/game'
require "./lib/parser"
require "./lib/word_search.rb"

class Response
  attr_reader        :request_counter,
                     :hello_counter,
                     :game

  def initialize
    @request_counter = 0
    @hello_counter   = -1
    @game            = Game.new
  end


  def path_controller(request_lines, guess = nil)
    @request_counter += 1
    parser = Parser.new(request_lines)
    path             = parser.get_path
    word             = parser.get_word
    verb             = parser.get_verb
    post_message     = parser.get_guess

    if verb == "GET"
      case path
      when '/'
        "<pre>" + main_output(request_lines).join("\n") + "</pre>"
      when '/hello'
        hello
      when '/datetime'
        date_and_time
      when '/shutdown'
        shutdown
      when "/word_search?word=#{word}"
        word_search  = WordSearch.new(word)
        word_search.result
      when '/game'
        game.display_last_guess
      else
        matrix_response
      end
    elsif verb == "POST"
      case path
      when '/start_game'
        game.start
      when '/game'
        game.guess_response(guess)
      else
        matrix_response
      end
    end
  end

  def date_and_time
    Time.now.strftime("%m:%M%p on %A, %B %e, %Y ")
  end

  def main_output(request_lines)
    Parser.new(request_lines).info
  end

  def matrix_response
    "Nothing to see here. Take the blue pill & return to the Matrix."
  end

  def shutdown
    "Total Requests: #{request_counter}"
  end

  def hello
    @hello_counter += 1
    "Hello World #{hello_counter}\n"
  end
end
