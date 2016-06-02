require 'minitest/autorun'
require 'minitest/pride'
# require 'faraday'
# require './lib/server'
require 'pry'
require './lib/parser'

class ParserTest < Minitest::Test
attr_reader  :request_lines,
             :response

  def setup
    @request_lines = ["GET /word_search?word=matrix HTTP/1.1", "Host: 127.0.0.1:9292", "Connection: keep-alive", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
    @response = Parser.new(request_lines)
  end

  def test_get_verb_returns_verb
    assert_equal "GET", response.get_verb
  end

  def test_get_word_parameter_returns_word_parameter
    assert_equal "matrix", response.get_word_parameter
  end

  def test_get_path_returns_path
    assert_equal "/word_search?word=matrix", response.get_path
  end

  def test_get_protocol_returns_protocol
    assert_equal "HTTP/1.1", response.get_protocol
  end

  def test_get_host_returns_host
    assert_equal "127.0.0.1", response.get_host
  end

  def test_get_port_returns_port
    assert_equal "9292", response.get_port
  end

  def test_get_accept_returns_acceptance_params
    assert_equal "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", response.get_accept
  end
end
