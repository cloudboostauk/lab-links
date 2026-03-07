cat << 'EOF' > app-v2.py
from flask import Flask, jsonify, request
import socket

app = Flask(__name__)

VERSION = "2.0"

products = [
    {"id": 1, "name": "Handmade Ceramic Mug", "price": 24.99, "reviews": 47},
    {"id": 2, "name": "Woven Wall Hanging", "price": 89.99, "reviews": 23},
    {"id": 3, "name": "Artisan Candle Set", "price": 34.99, "reviews": 89},
    {"id": 4, "name": "Wooden Cutting Board", "price": 44.99, "reviews": 12},
]

@app.route('/')
def home():
    html = f'''
    <!DOCTYPE html>
    <html>
    <head>
        <title>TechStart Store v{VERSION}</title>
        <style>
            body {{ font-family: Arial; margin: 40px; background: #e8f5e9; }}
            .container {{ background: white; padding: 30px; border-radius: 10px; max-width: 600px; }}
            .version {{ background: #27ae60; color: white; padding: 10px 20px; border-radius: 5px; display: inline-block; }}
            .new-badge {{ background: #e74c3c; color: white; padding: 3px 8px; border-radius: 3px; font-size: 12px; }}
            .product {{ border: 1px solid #ddd; padding: 15px; margin: 10px 0; border-radius: 5px; }}
            .reviews {{ color: #f39c12; }}
            .search-box {{ padding: 10px; width: 100%; margin: 10px 0; border: 2px solid #27ae60; border-radius: 5px; }}
            h1 {{ color: #27ae60; }}
        </style>
    </head>
    <body>
        <div class="container">
            <span class="version">Version {VERSION}</span>
            <span class="new-badge">NEW FEATURES!</span>
            <h1>TechStart Product Catalog</h1>
            <p>Served by: <strong>{socket.gethostname()}</strong></p>

            <input type="text" class="search-box" placeholder="Search products... (new in v2.0!)" disabled>

            <h2>Our Products</h2>
            {"".join(f'<div class="product"><strong>{p["name"]}</strong> - ${p["price"]} <span class="reviews">({p["reviews"]} reviews)</span></div>' for p in products)}
            <p style="color: #27ae60; margin-top: 20px;">v2.0: Now with search and reviews!</p>
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