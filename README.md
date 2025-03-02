# AI Dungeon Master - Interactive Text Adventure

An AI-powered text adventure game where a Mistral AI model acts as your Dungeon Master, creating dynamic storylines based on your choices.


##Useful things!
./update-all.sh

## 🎮 Features

- **AI Storytelling**: Dynamic narrative generation using Mistral AI
- **Interactive Gameplay**: Type commands to interact with the game world
- **Conversation Memory**: Game remembers previous interactions
- **Simple Interface**: Clean, dark-themed UI for immersive gameplay

## 🛠 Prerequisites

- Python 3.x
- Homebrew (for Mac users)
- Ollama (for running Mistral AI locally)

## ⚙️ Installation

1. **Install Homebrew** (Mac only):

bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
:

2. **Install Ollama**:
bash
brew install ollama
:

3. **Pull Mistral Model**:

bash
ollama pull mistral

4. **Clone the Repository**:

bash
git clone [your-repository-url]
cd [repository-name]

5. **Set Up Python Virtual Environment**:
bash
python3 -m venv venv
source venv/bin/activate

6. **Install Dependencies**:
bash
pip install -r requirements.txt

## 🚀 Running the Game

1. **Start Ollama** (in a separate terminal):
bash
ollama serve

2. **Activate Virtual Environment** (if not already activated):
bash
source venv/bin/activate

3. **Run the Flask Application**:
bash
python app.py

4. **Open in Browser**:
- Navigate to `http://localhost:5000`
- Start playing by typing your actions in the input box

## 🎮 How to Play

1. Wait for the initial prompt from the AI Dungeon Master
2. Type your actions or responses in the input box
3. Press Enter or click Send to submit
4. Read the AI's response and continue the adventure

## 📝 Notes

- Keep Ollama running in a separate terminal while playing
- The game saves conversation history in `conversation_history.json`
- To exit the virtual environment when done, type `deactivate`

## 🔧 Troubleshooting

- If you get connection errors, ensure Ollama is running (`ollama serve`)
- If the virtual environment isn't working, ensure it's activated
- For Mac users, always use `python3` instead of `python` if not in virtual environment

## 🛑 Common Errors

- **"command not found: python"**: Use `python3` instead
- **"externally-managed-environment"**: Make sure to use the virtual environment
- **"Connection refused"**: Ensure Ollama is running with `ollama serve`

## 🔄 Updates

To update Mistral model:
bash
ollama pull mistral

## 📦 Project Structure
.
├── app.py # Flask backend
├── templates/ # Frontend templates
│ └── index.html # Main game interface
├── requirements.txt # Python dependencies
└── README.md # This file

## 🤝 Contributing

not yet!