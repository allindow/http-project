require 'minitest/autorun'
require 'minitest/pride'
require './lib/parser'
require './lib/response'

class ResponseTest < Minitest::Test
  attr_reader :response

  def setup
    @response = Response.new(["<pre>Verb: GET", "Path: /", "Protocol: HTTP/1.1", "Host: 127.0.0.1", "Port: 9292", "Origin: 127.0.0.1", "Accept: */*</pre>"])
  end

  def test_response_accepts_request_lines
    response = Response.new("b")
    assert_equal "b", response.request_lines
  end

  def test_parser_instance_default
    response = Response.new("a")
    assert_instance_of Parser, response.parser
  end

  def test_date_time
    response = Response.new("something")
    time = response.date_and_time
    assert time.length > 0
  end

  def test_path_controller_for_slash
    skip
    response = Response.new("something")
    assert_equal response.path_controller("something", 0, 1, "/")
  end

  def test_path_controller_for_hello
    skip
    response = Response.new
    response.path_controller()
  end

  def test_path_controller_for_date_time
    skip
    response = Response.new
    response.path_controller()
  end

  def test_path_controller_for_shut_down
    skip
    response = Response.new
    response.path_controller()
  end

  def test_path_controller_for_bad_input
    skip
    response = Response.new
    response.path_controller()
  end
end
