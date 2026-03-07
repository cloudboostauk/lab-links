cat << 'EOF' > app-v3-buggy.py
from flask import Flask, jsonify
import socket
import sys
import threading
import time

app = Flask(__name__)

VERSION = "3.0"

# BUG: App crashes after 15 seconds
def crash_later():
    time.sleep(15)
    print("SIMULATED CRASH!")
    sys.exit(1)

threading.Thread(target=crash_later, daemon=True).start()

@app.route('/')
def home():
    html = f'''
    <!DOCTYPE html>
    <html>
    <head>
        <title>TechStart Store v{VERSION}</title>
        <style>
            body {{ font-family: Arial; margin: 40px; background: #ffebee; }}
            .container {{ background: white; padding: 30px; border-radius: 10px; max-width: 600px; border: 3px solid #e74c3c; }}
            .version {{ background: #e74c3c; color: white; padding: 10px 20px; border-radius: 5px; display: inline-block; }}
            .warning {{ background: #ffcc00; color: black; padding: 10px; margin: 15px 0; border-radius: 5px; }}
            h1 {{ color: #e74c3c; }}
        </style>
    </head>
    <body>
        <div class="container">
            <span class="version">Version {VERSION}</span>
            <h1>TechStart Product Catalog</h1>
            <p>Served by: <strong>{socket.gethostname()}</strong></p>
            <div class="warning">
                WARNING: This version has a critical bug!<br>
                The application will crash in ~15 seconds...
            </div>
            <p>New experimental features that are NOT stable.</p>
            <p style="color: #e74c3c;">This is what a bad deployment looks like!</p>
        </div>
    </body>
    </html>
    '''
    return html

@app.route('/health')
def health():
    return jsonify({"status": "healthy", "version": VERSION}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF