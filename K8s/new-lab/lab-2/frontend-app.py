cat << 'EOF' > frontend-app.py
from flask import Flask, jsonify
import requests
import socket
import os

app = Flask(__name__)

CATALOG_URL = os.environ.get('CATALOG_URL', 'http://catalog-service')

@app.route('/')
def home():
    return '''
    <html>
    <head><title>TechStart Store</title></head>
    <body>
        <h1>Welcome to TechStart!</h1>
        <p>Served by: ''' + socket.gethostname() + '''</p>
        <a href="/shop">View Products</a>
    </body>
    </html>
    '''

@app.route('/shop')
def shop():
    try:
        response = requests.get(f'{CATALOG_URL}/products', timeout=5)
        products = response.json()

        html = '<html><head><title>Products</title></head><body>'
        html += '<h1>Our Products</h1>'
        html += f'<p>Catalog served by: {products.get("served_by", "unknown")}</p>'
        html += '<ul>'
        for p in products.get('products', []):
            html += f'<li>{p["name"]} - ${p["price"]} ({p["stock"]} in stock)</li>'
        html += '</ul>'
        html += '<a href="/">Back</a></body></html>'
        return html
    except Exception as e:
        return f'<h1>Error connecting to catalog</h1><p>{str(e)}</p>'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3000)
EOF
