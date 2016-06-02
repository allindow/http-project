class WordSearch
  attr_reader   :word

  def initialize(word)
    @word = word << "\n"
  end

  def result
    exists? ? exist_output : nonexist_output
  end

  def dictionary
    IO.readlines("/usr/share/dict/words")
  end

  def exists?
    dictionary.include?(word)
  end

  def exist_output
    "<html><head></head><body>#{word.upcase} is a known word.</body></html>"
  end

  def nonexist_output
    "<html><head></head><body>#{word.upcase} is not a known word.</body></html>"
  end

end
