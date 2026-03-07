cat << 'EOF' > app-slow.py
from flask import Flask, jsonify
import socket
import time
import threading

app = Flask(__name__)

ready = False

# App takes 20 seconds to "warm up"
def warmup():
    global ready
    print("App starting... warming up for 20 seconds")
    time.sleep(20)
    ready = True
    print("App is now READY to serve traffic")

threading.Thread(target=warmup, daemon=True).start()

@app.route('/')
def home():
    return jsonify({"version": "slow-start", "hostname": socket.gethostname()})

@app.route('/health')
def health():
    if ready:
        return jsonify({"status": "ready"}), 200
    else:
        return jsonify({"status": "warming up"}), 503

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF
