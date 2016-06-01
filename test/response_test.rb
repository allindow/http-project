require 'minitest/autorun'
require 'minitest/pride'
require './lib/parser'
require './lib/response'

class ResponseTest < Minitest::Test
  attr_reader :response, :test_request, :parsed_request_info

  def setup
    @response = Response.new
    @test_request = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "Connection: keep-alive", "Cache-Control: no-cache", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36", "Postman-Token: 68e69e87-8ac6-0b35-2ca3-2c96889f8ca6", "Accept: */*", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
    @parsed_request_info = ["<html>Verb: GET", "Path: /", "Protocol: HTTP/1.1", "Host: 127.0.0.1", "Port: 9292", "Origin: 127.0.0.1", "Accept: */*</html>"]
  end

  def test_new_instance_of_parser
    assert_instance_of Parser, response.parser
  end

  def test_request_defaults_empty
    assert_equal [], response.request
  end

  def test_date_and_time
    time_now = Time.now.strftime("%m:%M%p on %A, %B %e, %Y ")
    assert_equal time_now, response.date_and_time
  end

  def test_information_being_inputted
    assert_equal parsed_request_info, response.info(test_request)
  end


end
