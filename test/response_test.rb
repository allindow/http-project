require 'minitest/autorun'
require 'minitest/pride'
require './lib/parser'
require './lib/response'

class ResponseTest < Minitest::Test
  attr_reader :response,
              :test_request,
              :parsed_request_info


  def setup
    @response = Response.new
    @test_request = ["GET /word_search?word=super HTTP/1.1", "Host: 127.0.0.1:9292", "Connection: keep-alive", "Cache-Control: no-cache", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36", "Postman-Token: 68e69e87-8ac6-0b35-2ca3-2c96889f8ca6", "Accept: */*", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
    @parsed_request_info = ["Verb: GET", "Path: /word_search?word=super", "Protocol: HTTP/1.1", "Host: 127.0.0.1", "Port: 9292", "Origin: 127.0.0.1", "Accept: */*"]
  end

  def test_hello_counter_starts_at_negative_one
    assert_equal -1, response.hello_counter
  end

  def test_request_counter_starts_at_zero
    assert_equal 0, response.request_counter
  end

  def test_main_output_provides_default_request_info
    assert_equal parsed_request_info, response.main_output(test_request)
  end

  def test_date_and_time
    time_now = Time.now.strftime("%m:%M%p on %A, %B %e, %Y ")
    assert_equal time_now, response.date_and_time
  end

  def test_formatter_provides_html_formatting
    assert_equal   "<html><head></head><body>" + "hello" + "</body></html>", response.formatter("hello")
  end

  def test_if_word_exists_returns_true
    skip
    assert response.word_exists?(test_request)
  end

  def test_nonsense_word_returns_false
    skip
    nonsense = ["GET /word_search?word=sfdjahsdf HTTP/1.1", "Host: 127.0.0.1:9292", "Connection: keep-alive", "Cache-Control: no-cache", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36", "Postman-Token: 68e69e87-8ac6-0b35-2ca3-2c96889f8ca6", "Accept: */*", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
    refute response.word_exists?(nonsense)
  end

end
