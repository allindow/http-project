# require 'minitest/autorun'
# require 'minitest/pride'
# require 'faraday'
# require './lib/server'
# require 'pry'
#
# class SeverTest < Minitest::test
#
#   def setup
#     @connection - Faraday.new('http://127.0.0.1:9292')
#     faraday.request :url_encoded
#     faraday.adapter Faraday.default_adapter
#   end
#
#   def test_server_responds_to_request
#     response = Faraday.get('http://127.0.0.1:9292')
#     assert_equal nil,response.inspect
#   end
#
# end
