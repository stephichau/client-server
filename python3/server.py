from select import select
import socket
from threading import Thread

class Server:
  def __init__(self, host = '127.0.0.1', port = 8080):
    self.host = host
    self.port = port
    self.socket_server = None

  def start(self):
    print("Starting server on port {}".format(self.port))
    self.socket_server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    self.socket_server.bind((self.host, self.port))
    self.socket_server.listen(5)
    
    print("Starting thread to accept client connections...")
    thread_accept = Thread(target=self.accept_client, args=tuple())
    thread_accept.daemon = True
    thread_accept.start()

  def accept_client(self):
    print("Waiting for client connections...")

    while True:
      socket_client, address = self.socket_server.accept()

      print("Accepted client: {}\n".format(socket_client))

      thread_messages = Thread(target=self.receive_message, args=(socket_client, ))
      thread_messages.daemon = True
      thread_messages.start()
  
  def receive_message(self, client):
    while True:
      data = client.recv(1024)

      decoded_data = data.decode('utf-8').strip()

      if decoded_data:
        print(decoded_data)

server = Server(host = "127.0.0.1", port = 8080)
should_keep_running = True
server.start()

while should_keep_running:
  user_input = input("\n\nType q to shut down\n\n")

  if user_input == 'q':
    should_keep_running = False
