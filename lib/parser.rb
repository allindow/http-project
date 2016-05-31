# require "./lib/server"
# # require "socket"
# require "./lib/response"

class Parser
attr_reader :request_lines

def initialize(request_lines)
  @request_lines = request_lines
end

def get_verb
  request_lines[0].split(" ")[0]
end

def get_path
  request_lines[0].split(" ")[1]
end

def get_protocol
  request_lines[0].split(" ")[2]
end

def get_host
  request_lines[1].split(":")[1].strip
end

def get_port
  request_lines[1].split(":")[2]
end

def get_accept
  request_lines[3]
end
end
