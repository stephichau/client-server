## Installation

This script was built using Python v3.10.6

## How to use
In one tab, run `server.py`:

```bash
python3 server.py
```

To exit the server either type `q` or use `CTRL+ C`.

On another tab, run the client side:

```bash
python3 client.py
```

To exit the client use on `CTRL + C`.

## Considerations

This script handles receiving messages from multiple clients.

If messages are longer than 1024 bytes, the server might "cut" the message in different chunks.