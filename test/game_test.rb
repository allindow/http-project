require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'

class GameTest < Minitest::Test
  attr_reader :game

  def setup
    @game = Game.new
  end

  def test_new_game_generates_random_number
    number = game.start
    assert Integer, number.class
  end

  def test_guesses_start_at_zero
    assert_equal 0, game.guess_counter
  end

  def test_number_only_generates_at_start
    assert_equal nil, @generated_number
  end

  def test_too_high_response
    assert_equal "Guess is too high", game.too_high
  end

  def test_too_low_response
    assert_equal "Guess is too low", game.too_low
  end

  def test_correct_response
    assert_equal "Guess is correct!", game.correct
  end

  def test_making_a_guess
    game.start
    response = game.make_a_guess(5)
    assert_equal true, response.include?("Guess")
  end

  def test_not_following_the_rules
    game.start
    assert_equal "You must follow the rules. Guess between 0 and 100.", game.make_a_guess("Hello")
  end

  def test_display_last_guess
    game.start
    game.make_a_guess(5)
    assert_equal "Your last guess was 5. ""You have made 1 guess/es. ""Guess is too low", game.display_last_guess
  end
end
