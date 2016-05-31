require "./server"
require "socket"
require "./response"

class Parser

def initialize(request_lines)

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
