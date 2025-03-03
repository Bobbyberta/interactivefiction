#!/bin/bash

# Store the root directory
ROOT_DIR=$(pwd)

# Function to check if a process is running on a port
check_port() {
    if lsof -i:$1 > /dev/null; then
        return 0
    else
        return 1
    fi
}

echo "🚀 Starting local development environment..."

# Check if backend port is available
if check_port 5001; then
    echo "❌ Error: Port 5001 is already in use"
    exit 1
fi

# Setup and start backend
echo "🔧 Setting up backend..."
cd "${ROOT_DIR}/backend" || exit
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi
source venv/bin/activate
pip install -r requirements.txt

# Start backend
echo "🚀 Starting backend server..."
python app.py &
BACKEND_PID=$!

# Open frontend
echo "🎨 Opening frontend..."
# Start a Python HTTP server for the frontend
cd "${ROOT_DIR}/frontend/docs" || exit
python3 -m http.server 8000 &
FRONTEND_PID=$!

# Wait a moment for the server to start
sleep 2

# Open the browser
if [[ "$OSTYPE" == "darwin"* ]]; then
    open "http://localhost:8000"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    xdg-open "http://localhost:8000"
elif [[ "$OSTYPE" == "msys" ]]; then
    start "http://localhost:8000"
fi

echo "✅ Development environment is ready!"
echo "📝 Backend running on http://localhost:5001"
echo "🎮 Frontend running on http://localhost:8000"
echo ""
echo "To stop the servers, press Ctrl+C"

# Wait for Ctrl+C
trap 'kill $BACKEND_PID $FRONTEND_PID; echo "🛑 Shutting down..."; exit 0' SIGINT
wait 