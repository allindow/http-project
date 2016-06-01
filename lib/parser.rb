# require "./lib/server"
# # require "socket"
# require "./lib/response"

class Parser



def get_verb(request_lines)
  request_lines[0].split(" ")[0]
end

def get_path(request_lines)
  request_lines[0].split(" ")[1]
end

def get_protocol(request_lines)
  request_lines[0].split(" ")[2]
end

def get_host(request_lines)
  request_lines[1].split(":")[1].strip
end

def get_port(request_lines)
  request_lines[1].split(":")[2]
end

def get_accept(request_lines)
  accept_index = request_lines.find_index{|word| word.match( /Accept:/ ) }
  request_lines[accept_index]
end
end
