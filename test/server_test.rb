require 'minitest/autorun'
require 'minitest/pride'
require 'faraday'
# require './lib/server'
require 'pry'
#
class SeverTest < Minitest::Test

  def test_server_responds_to_request
    response = Faraday.get('http://127.0.0.1:9292')
    assert response.body.include?("GET")
  end

end
