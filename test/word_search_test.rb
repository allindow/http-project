require 'minitest/autorun'
require 'minitest/pride'
require './lib/word_search'
require 'rake/testtask'


class WordSearchTest < Minitest::Test
  attr_reader     :word,
                  :word_search
  def setup
    @word        = "matrix"
    @word_search = WordSearch.new(word)
  end

  def test_word_search_takes_word_parameter
    assert_instance_of WordSearch, WordSearch.new(word)
  end

  def test_it_has_a_dictionary
    assert_equal IO.readlines("/usr/share/dict/words"), word_search.dictionary
  end

  def test_true_if_word_exists
    assert word_search.exists?
  end

  def test_false_if_not_a_word
    nonsense = WordSearch.new("asdlfasf")
    refute nonsense.exists?
  end

  def test_output_for_existing_word
    assert_equal "<html><head></head><body>#{word.upcase} is a known word.</body></html>", word_search.exist_output
  end

  def test_output_for_existing_word
    assert_equal "<html><head></head><body>#{word.upcase} is not a known word.</body></html>", word_search.nonexist_output
  end

  def test_result_provides_correct_output_for_existing_word
    assert_equal word_search.exist_output,word_search.result
  end

  def test_result_provides_correct_output_for_nonexisting_word
    nonsense = WordSearch.new("asdlfasf")
    assert_equal nonsense.nonexist_output,nonsense.result
  end

end
