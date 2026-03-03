cat << 'EOF' > app.py
from flask import Flask, jsonify
import socket
import os

app = Flask(__name__)

# TechStart Product Catalog
products = [
    {"id": 1, "name": "Handmade Ceramic Mug", "price": 24.99, "stock": 150},
    {"id": 2, "name": "Woven Wall Hanging", "price": 89.99, "stock": 45},
    {"id": 3, "name": "Artisan Candle Set", "price": 34.99, "stock": 200},
    {"id": 4, "name": "Hand-painted Vase", "price": 64.99, "stock": 30},
]

@app.route('/')
def home():
    return jsonify({
        "service": "TechStart Product Catalog",
        "version": "1.0",
        "hostname": socket.gethostname(),
        "status": "healthy"
    })

@app.route('/products')
def get_products():
    return jsonify({
        "products": products,
        "served_by": socket.gethostname()
    })

@app.route('/health')
def health():
    return jsonify({"status": "healthy"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF
