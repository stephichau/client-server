require 'socket'

class Server
  include Socket::Constants

  def initialize(host, port)
    @host = host
    @port = port

    @connections = {}
  end

  def start
    puts "Starting server..."
    @socket = Socket.new(AF_INET, SOCK_STREAM, 0)

    sockaddr = Socket.pack_sockaddr_in(@port, @host)
    @socket.bind(sockaddr)
    @socket.listen(5)

    t = Thread.new do
      listen_for_clients(@socket)
    end

    t.join

    puts "Thread #{t} initialized"
  end

  private

  def add_connection(socket_client:, client_address_info:)
    @connections[socket_client] = client_address_info
  end

  def listen_for_clients(socket)
    puts "Listening for new connections..."
    loop do
      socket_client, client_address_info = socket.accept
      puts "New connection: #{socket_client}"

      add_connection(socket_client: socket_client, client_address_info: client_address_info)

      t = Thread.new do
        receive_message(socket_client)
      end

      t.join

      puts "New connection started receiving messages..."
    end
  end

  def receive_message(client)
    data = client.recvfrom(1024)

    puts "Got data from #{client}"

    return if data[0].chomp.empty?

    until data[0]
      puts data[0].chomp
      data = client.recvfrom(1024)
    end

    puts data[0].chomp
  end
end

server = Server.new('127.0.0.1', 8081)
server.start
