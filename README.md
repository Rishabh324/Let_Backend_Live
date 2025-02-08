### Setup backend script

Step-1) Clone the above repo.

Step-2) Move the 'let_backend_live.sh' file to /usr/local/bin directory. Now update the file by replacing the backend urls with the test urls of your hosted backend. Save the file.

Step-3) Run the below command on the terminal.

```
sudo nano /etc/systemd/system/let_backend_live.service
```

A nano code editor will be opened. Then add the following code snippet in the editor and Save the file.

```
[Unit]
Description=Keep Backend Alive Daemon
After=network.target

[Service]
ExecStart=/usr/local/bin/let_backend_live
Restart=always
RestartSec=10
User=root

[Install]
WantedBy=multi-user.target
```

Step-4) Now reload and restart the service by running these commands.

```
sudo systemctl daemon-reload
sudo systemctl reset-failed
sudo systemctl restart keep_backend_alive
```

### You are good to go. Your backend is immortal now.
