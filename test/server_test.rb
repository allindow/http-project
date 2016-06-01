require 'minitest/autorun'
require 'minitest/pride'
require 'faraday'
# require './lib/server'
require 'pry'
#
class SeverTest < Minitest::Test
#   attr_reader :conn
#
#   def setup
#     @conn = Faraday.new(:url => 'http://127.0.0.1:9292') do |faraday|
#     faraday.request :url_encoded
#     faraday.response :logger
#     faraday.adapter Faraday.default_adapter
#   end
# end

  def test_server_responds_to_request
    thing = Faraday.new('http://127.0.0.1:9292')
    # response = Faraday.get('http://127.0.0.1:9292')
    require "pry"; binding.pry
    response = thing.get
    assert response.include?("GET")
  end

end
