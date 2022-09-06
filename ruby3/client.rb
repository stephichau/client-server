require 'socket'

class Client
  include Socket::Constants

  def initialize(host:, port:)
    @host = host
    @port = port
  end

  def start
    @socket = Socket.new(AF_INET, SOCK_STREAM, 0)
    sockaddr = Socket.pack_sockaddr_in(@port, @host)

    @socket.connect(sockaddr)
  end

  def send_message
    loop do
      user_input = gets

      @socket.puts(user_input.chomp)
    end
  end
end

client = Client.new(host: '127.0.0.1', port: 8081)
client.start
client.send_message
