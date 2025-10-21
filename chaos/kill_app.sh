#!/bin/bash
# Kill application process by name
# Usage: ./kill_app.sh <process_name>

APP_NAME=$1
if [ -z "$APP_NAME" ]; then
  echo "Usage: ./kill_app.sh <process_name>"
  exit 1
fi

PID=$(pgrep -f $APP_NAME)
if [ -z "$PID" ]; then
  echo "Process $APP_NAME not found"
  exit 1
fi

echo "Killing process $APP_NAME (PID $PID)"
kill -15 $PID
echo "Process killed. You may restart manually."
