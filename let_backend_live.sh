#!/bin/bash

# URLs of your backend
URLS=(
    "BACKEND_URL_1"
    "BACKEND_URL_2"
    ...
)

# Log file location
LOG_FILE="/var/log/let_backend_live.log"

# Function to ping the backend
ping_backend() {
    while true; do
        for url in "${URLS[@]}"; do
            RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" "$url")
            if [ "$RESPONSE" -eq 200 ]; then
                echo "$(date): Ping successful - $url - Status code: $RESPONSE" | tee -a "$LOG_FILE"
            else
                echo "$(date): Ping failed - $url - Status code: $RESPONSE" | tee -a "$LOG_FILE"
            fi
        done
        sleep 900  # Wait for 15 minutes before the next ping
    done
}

# Function to run as a daemon
start_daemon() {
    nohup bash -c "ping_backend" >/dev/null 2>&1 &
    echo $! > /var/run/let_backend_live.pid  # Store PID of the daemon process
}

# Start the daemon
start_daemon

