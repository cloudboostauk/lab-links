cat << 'EOF' > app-stuck.py
from flask import Flask, jsonify
import socket
import time
import threading

app = Flask(__name__)

healthy = True

# Become unhealthy after 30 seconds
def become_unhealthy():
    global healthy
    time.sleep(30)
    healthy = False
    print("App is now UNHEALTHY - liveness probe should fail")

threading.Thread(target=become_unhealthy, daemon=True).start()

@app.route('/')
def home():
    return jsonify({"version": "stuck", "hostname": socket.gethostname()})

@app.route('/health')
def health():
    if healthy:
        return jsonify({"status": "healthy"}), 200
    else:
        return jsonify({"status": "unhealthy"}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF