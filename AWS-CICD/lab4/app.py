from flask import Flask, jsonify, render_template_string

app = Flask(__name__)

HTML = """<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>QuickShop API</title>
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
           background: #f5f5f4; color: #1c1917; min-height: 100vh;
           display: flex; align-items: center; justify-content: center; padding: 2rem; }
    .card { background: #fff; border: 1px solid #e7e5e4; border-radius: 12px;
            padding: 2rem; width: 100%; max-width: 480px; }
    .header { display: flex; align-items: center; gap: 12px; margin-bottom: 1.75rem; }
    .icon { width: 40px; height: 40px; background: #f0fdf4; border: 1px solid #bbf7d0;
            border-radius: 8px; display: flex; align-items: center; justify-content: center;
            font-size: 20px; }
    h1 { font-size: 17px; font-weight: 600; }
    .sub { font-size: 13px; color: #78716c; margin-top: 2px; }
    .pill { margin-left: auto; display: flex; align-items: center; gap: 6px;
            background: #f0fdf4; border: 1px solid #bbf7d0; border-radius: 99px;
            padding: 4px 12px; font-size: 12px; font-weight: 500; color: #15803d; }
    .dot { width: 7px; height: 7px; border-radius: 50%; background: #22c55e; }
    .grid { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-bottom: 1.25rem; }
    .metric { background: #fafaf9; border: 1px solid #e7e5e4; border-radius: 8px; padding: 12px 14px; }
    .metric-label { font-size: 11px; color: #78716c; margin-bottom: 5px; text-transform: uppercase; letter-spacing: 0.04em; }
    .metric-value { font-size: 18px; font-weight: 600; }
    .raw { background: #fafaf9; border: 1px solid #e7e5e4; border-radius: 8px;
           padding: 12px 14px; margin-bottom: 1.25rem; }
    .raw-label { font-size: 11px; color: #78716c; margin-bottom: 8px; text-transform: uppercase; letter-spacing: 0.04em; }
    pre { font-family: 'SF Mono', 'Fira Code', monospace; font-size: 12px;
          color: #1c1917; white-space: pre-wrap; word-break: break-all; }
    .footer { display: flex; align-items: center; gap: 10px; }
    button { background: #fff; border: 1px solid #d6d3d1; border-radius: 8px;
             padding: 8px 16px; font-size: 13px; cursor: pointer; display: flex;
             align-items: center; gap: 6px; font-family: inherit; }
    button:hover { background: #fafaf9; }
    button:active { transform: scale(0.98); }
    .ts { font-size: 12px; color: #a8a29e; margin-left: auto; }
    .spin { display: inline-block; animation: spin 1s linear infinite; }
    @keyframes spin { to { transform: rotate(360deg); } }
  </style>
</head>
<body>
  <div class="card">
    <div class="header">
      <div class="icon">🛍️</div>
      <div>
        <h1>QuickShop API</h1>
        <div class="sub">ECS Fargate &middot; eu-west-2</div>
      </div>
      <div class="pill">
        <span class="dot"></span>
        <span id="status-text">running</span>
      </div>
    </div>

    <div class="grid">
      <div class="metric">
        <div class="metric-label">Service</div>
        <div class="metric-value" id="m-service" style="font-size:14px;padding-top:3px;">QuickShop API</div>
      </div>
      <div class="metric">
        <div class="metric-label">Status</div>
        <div class="metric-value" id="m-status" style="color:#15803d;">running</div>
      </div>
      <div class="metric">
        <div class="metric-label">Version</div>
        <div class="metric-value" id="m-version">1.0.0</div>
      </div>
      <div class="metric">
        <div class="metric-label">Last checked</div>
        <div class="metric-value" id="m-time" style="font-size:13px;padding-top:3px;">—</div>
      </div>
    </div>

    <div class="raw">
      <div class="raw-label">Raw API response</div>
      <pre id="raw-out">Click Refresh to fetch live data</pre>
    </div>

    <div class="footer">
      <button id="btn" onclick="refresh()">&#x21BB; Refresh</button>
      <span class="ts" id="ts">—</span>
    </div>
  </div>

  <script>
    function fmt(d) {
      return d.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', second: '2-digit' });
    }

    async function refresh() {
      const btn = document.getElementById('btn');
      btn.innerHTML = '<span class="spin">&#x21BB;</span> Checking…';
      btn.disabled = true;
      try {
        // calls /api — pure JSON, separate from the UI route
        const res = await fetch('/api');
        const data = await res.json();
        const now = new Date();
        document.getElementById('m-service').textContent = data.service || '—';
        document.getElementById('m-status').textContent  = data.status  || '—';
        document.getElementById('m-version').textContent = data.version || '—';
        document.getElementById('m-time').textContent    = fmt(now);
        document.getElementById('status-text').textContent = data.status || '—';
        document.getElementById('raw-out').textContent   = JSON.stringify(data, null, 2);
        document.getElementById('ts').textContent        = 'Updated at ' + fmt(now);
      } catch(e) {
        document.getElementById('raw-out').textContent = 'Error: ' + e.message;
        document.getElementById('ts').textContent = 'Failed at ' + fmt(new Date());
      }
      btn.innerHTML = '&#x21BB; Refresh';
      btn.disabled = false;
    }

    // Auto-refresh on load
    refresh();
  </script>
</body>
</html>"""


@app.route('/')
def home():
    return render_template_string(HTML)      # UI lives at /


@app.route('/api')
def api():
    return jsonify({                        
        'service': 'QuickShop API',
        'status':  'running',
        'version': '2.0.0' #change from 1.0.0 to 2.0.0 to trigger a new build
    })


@app.route('/health')
def health():
    return jsonify({'status': 'healthy'}), 200


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)