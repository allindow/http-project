# require "./lib/server"
# # require "socket"
# require "./lib/response"

class Parser
attr_reader :request_lines

def initialize(request_lines)
  @request_lines = request_lines
end

def verb
  request_lines[0].split(" ")[0]
end

def path
  request_lines[0].split(" ")[1]
end

def protocol
  request_lines[0].split(" ")[2]
end

def host
  request_lines[1].split(":")[1]
end

def port
  request_lines[1].split(":")[2]
end

def accept
  request_lines[4]
end
end
