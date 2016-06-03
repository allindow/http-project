
class Parser
  attr_reader     :request_lines

  def initialize(request_lines)
    @request_lines = request_lines
  end

  def info
    ["Verb: #{get_verb}","Path: #{get_path}","Protocol: #{get_protocol}",
      "Host: #{get_host}","Port: #{get_port}","Origin: #{get_host}","#{get_accept}"]
  end

  def get_verb
    request_lines[0].split(" ")[0]
  end

  def get_path
    request_lines[0].split(" ")[1]
  end

  def get_word
    get_path.split(/\W+/)[-1]
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
    accept_index = request_lines.find_index{|word| word.match( /Accept:/ ) }
    request_lines[accept_index]
  end

  def get_guess
    request_lines[-1]
  end

  def get_content_length
    length_index = request_lines.find_index{|word| word.match( /Content-Length:/ ) }
    if length_index != nil
    request_lines[length_index].split(":")[1].strip
  end
end

end
