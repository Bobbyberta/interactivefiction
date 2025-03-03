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

# Function to check if Ollama is running
check_ollama() {
    if curl -s http://localhost:11434/api/tags >/dev/null; then
        return 0
    else
        return 1
    fi
}

echo "🚀 Starting local development environment..."

# Check if Ollama is running
if ! check_ollama; then
    echo "📦 Starting Ollama..."
    ollama serve &
    sleep 5  # Wait for Ollama to start
fi

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
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    open "${ROOT_DIR}/frontend/docs/index.html"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    xdg-open "${ROOT_DIR}/frontend/docs/index.html"
elif [[ "$OSTYPE" == "msys" ]]; then
    # Windows
    start "${ROOT_DIR}/frontend/docs/index.html"
fi

echo "✅ Development environment is ready!"
echo "📝 Backend running on http://localhost:5001"
echo "🎮 Frontend opened in your browser"
echo ""
echo "To stop the servers, press Ctrl+C"

# Wait for Ctrl+C
trap 'kill $BACKEND_PID; echo "🛑 Shutting down..."; exit 0' SIGINT
wait 