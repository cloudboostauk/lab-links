cat << 'EOF' > app-v4-scaling.py
from flask import Flask, jsonify
import socket
import os
import time

app = Flask(__name__)

VERSION = "4.0"
START_TIME = time.time()

# Simulate CPU-intensive work
def cpu_work():
    total = 0
    for i in range(100000):
        total += i * i
    return total

@app.route('/')
def home():
    # Do some CPU work to make scaling visible
    cpu_work()

    uptime = int(time.time() - START_TIME)
    hostname = socket.gethostname()

    # Get secrets from environment (if available)
    db_user = os.environ.get('DB_USERNAME', 'not set')
    db_pass = os.environ.get('DB_PASSWORD', 'not set')
    db_host = os.environ.get('DB_HOST', 'not set')

    # Mask password for display
    masked_pass = db_pass[:3] + '****' if len(db_pass) > 3 else '****'

    html = f'''
    <!DOCTYPE html>
    <html>
    <head>
        <title>TechStart v{VERSION} - Scaling Demo</title>
        <meta http-equiv="refresh" content="3">
        <style>
            body {{ font-family: Arial; margin: 40px; background: #e3f2fd; }}
            .container {{ background: white; padding: 30px; border-radius: 10px; max-width: 600px; }}
            .version {{ background: #9c27b0; color: white; padding: 10px 20px; border-radius: 5px; display: inline-block; }}
            .hostname {{ background: #ff9800; color: white; padding: 15px; margin: 15px 0; border-radius: 5px; font-size: 18px; }}
            .secrets {{ background: #f5f5f5; padding: 15px; margin: 15px 0; border-radius: 5px; border-left: 4px solid #4caf50; }}
            .refresh {{ color: #666; font-size: 12px; }}
            h1 {{ color: #9c27b0; }}
        </style>
    </head>
    <body>
        <div class="container">
            <span class="version">Version {VERSION} - Scaling Demo</span>
            <h1>TechStart Product Catalog</h1>

            <div class="hostname">
                Pod: <strong>{hostname}</strong><br>
                <small>Refresh to see different pods responding (load balancing)</small>
            </div>

            <div class="secrets">
                <strong>Injected Secrets:</strong><br>
                DB_USERNAME: {db_user}<br>
                DB_PASSWORD: {masked_pass}<br>
                DB_HOST: {db_host}
            </div>

            <p>Pod uptime: {uptime} seconds</p>
            <p class="refresh">Page auto-refreshes every 3 seconds</p>
            <p style="color: #9c27b0;">Watch the Pod name change as HPA scales up!</p>
        </div>
    </body>
    </html>
    '''
    return html

@app.route('/health')
def health():
    return jsonify({"status": "healthy", "version": VERSION}), 200

@app.route('/load')
def load():
    # Heavy CPU work for load testing
    for _ in range(10):
        cpu_work()
    return jsonify({"status": "loaded", "hostname": socket.gethostname()})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF
