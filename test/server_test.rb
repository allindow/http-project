require 'minitest/autorun'
require 'minitest/pride'
require 'faraday'
require './lib/server'
require 'pry'

class SeverTest < Minitest::test

  def test_server_responds_to_request
    response = Faraday.get('http://127.0.0.1:9292')
    assert response.success?
  end
end
