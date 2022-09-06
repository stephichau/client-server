import socket

class Client:
  def __init__(self, host = "127.0.0.1", port = 8080):
    self.host = host
    self.port = port
    self.server_socket = None

  def start(self):
    self.server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    self.server_socket.connect((self.host, self.port))

  def send_message(self):
    message = input("Type to send message:\n\n")

    self.server_socket.send(message.encode("utf-8"))


client = Client(host = "127.0.0.1", port = 8080)
client.start()

while True:
  client.send_message()
