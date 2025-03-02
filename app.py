from flask import Flask, request, jsonify, render_template
import json
from pathlib import Path
import requests
import time

app = Flask(__name__)

HISTORY_FILE = "conversation_history.json"

def load_history():
    if Path(HISTORY_FILE).exists():
        with open(HISTORY_FILE, 'r') as f:
            return json.load(f)
    return []

def save_history(history):
    with open(HISTORY_FILE, 'w') as f:
        json.dump(history, f)

def generate_story_response(player_input, history):
    # Construct the prompt for the AI
    context = "\n".join([f"{'DM' if i%2==0 else 'Player'}: {msg}" 
                        for i, msg in enumerate(history[-4:])]) if history else ""
    
    prompt = f"""You are a Dungeon Master in a text adventure game. Keep responses under 100 words and engaging.
Previous context:
{context}

Player: {player_input}

Respond as the DM, describing the scene and possible actions:"""

    # Call Ollama API
    response = requests.post('http://localhost:11434/api/generate',
                           json={
                               "model": "mistral",
                               "prompt": prompt,
                               "stream": False
                           })
    
    return response.json()['response']

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/story', methods=['POST'])
def story():
    data = request.json
    player_input = data.get('input', '')
    
    # Load history
    history = load_history()
    
    # Generate AI response
    ai_response = generate_story_response(player_input, history)
    
    # Update history
    if not history or player_input != history[-1]:
        history.append(player_input)
        history.append(ai_response)
        save_history(history)
    
    return jsonify({
        'response': ai_response,
        'history': history
    })

if __name__ == '__main__':
    app.run(debug=True) 