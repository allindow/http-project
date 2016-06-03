
class Game
  attr_reader :guessing_number,
              :guess_counter,
              :guess_tracker

  def initialize
    @generated_number = nil
    @guess_counter    = 0
    @guess_tracker    = []
  end

  def make_a_guess(guess)
    guess = guess.to_i
    @guess_tracker << guess
    @guess_counter += 1
      if guess == 0 || guess > 100
        "You must follow the rules. Guess between 0 and 100."
      elsif guess > @generated_number
        too_high
      elsif guess < @generated_number
        too_low
      elsif guess == @generated_number
        correct
      end
    end

    def last_guess
      @guess_tracker[-1]
    end

    def last_guess_info
      "Your last guess was #{last_guess}. " +
      "You have made #{guess_counter} guess/es. "
    end

    def display_last_guess
        if @generated_number.nil?
          "Please start game."
        elsif last_guess > @generated_number
          last_guess_info + too_high
        elsif last_guess < @generated_number
          last_guess_info + too_low
        elsif last_guess == @generated_number
          last_guess_info + correct
        end
      end

    def too_high
      "Guess is too high"
    end

    def too_low
      "Guess is too low"
    end

    def correct
      "Guess is correct!"
    end

    def start
      @generated_number = rand(0...100)
      "Good luck!"
    end
  end
