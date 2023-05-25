#!/bin/bash

# Set the port
PORT=8082

# Stop any program currently running on the set port
echo "Preparing port $PORT..."
PID=$(netstat -tuln | grep ":$PORT " | awk '{print $7}' | awk -F'/' '{print $1}')
if [ -n "$PID" ]; then
  echo "Stopping process on port $PORT (PID: $PID)..."
  kill "$PID"
fi

# switch directories
cd build/web/

# Start the server
echo 'Server starting on port' $PORT '...'
python3 -m http.server $PORT