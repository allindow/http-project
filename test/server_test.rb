require 'minitest/autorun'
require 'minitest/pride'
require 'faraday'
require 'rake/testtask'

class SeverTest < Minitest::Test

  def test_server_response_shows_verb_in_body
    response = Faraday.get('http://127.0.0.1:9292')
    assert response.success?
    assert response.body.include?("GET")
  end

  def test_hello_page_returns_hello_world
    response = Faraday.get('http://127.0.0.1:9292/hello')
    assert response.body.include?("Hello World")
    assert response.success?
  end

  def test_datetime_page_returns_month
    response = Faraday.get('http://127.0.0.1:9292/datetime')
    assert response.body.include?("June")
    assert response.success?
  end

  def test_unlisted_page_returns_blue_pill_message
    response = Faraday.get('http://127.0.0.1:9292/whatever')
    assert response.body.include?("Take the blue pill")
    assert response.success?
  end

  def test_shutdown_page_closes_server
    skip
    response = Faraday.get('http://127.0.0.1:9292/shutdown')
    assert response.body.include?("Total Requests:")
    assert response.success?
    `ruby ./lib/server.rb`
    sleep 5
  end

end
