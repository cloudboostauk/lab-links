from flask import Flask, jsonify
import socket

app = Flask(__name__)

VERSION = "1.0"

products = [
    {"id": 1, "name": "Handmade Ceramic Mug", "price": 24.99},
    {"id": 2, "name": "Woven Wall Hanging", "price": 89.99},
    {"id": 3, "name": "Artisan Candle Set", "price": 34.99},
]

@app.route('/')
def home():
    html = f'''
    <!DOCTYPE html>
    <html>
    <head>
        <title>TechStart Store v{VERSION}</title>
        <style>
            body {{ font-family: Arial; margin: 40px; background: #f0f0f0; }}
            .container {{ background: white; padding: 30px; border-radius: 10px; max-width: 600px; }}
            .version {{ background: #3498db; color: white; padding: 10px 20px; border-radius: 5px; display: inline-block; }}
            .product {{ border: 1px solid #ddd; padding: 15px; margin: 10px 0; border-radius: 5px; }}
            h1 {{ color: #2c3e50; }}
        </style>
    </head>
    <body>
        <div class="container">
            <span class="version">Version {VERSION}</span>
            <h1>TechStart Product Catalog</h1>
            <p>Served by: <strong>{socket.gethostname()}</strong></p>
            <h2>Our Products</h2>
            {"".join(f'<div class="product"><strong>{p["name"]}</strong> - ${p["price"]}</div>' for p in products)}
            <p style="color: #888; margin-top: 20px;">Basic catalog - no search or reviews</p>
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