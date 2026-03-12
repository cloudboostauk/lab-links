#!/bin/bash
# Switch to root user
sudo su

# Fetch IMDSv2 Token
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Retrieve instance metadata using IMDSv2
PRIVATE_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/local-ipv4)
HOSTNAME=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/hostname)

# Update and install Apache (httpd)
yum update -y
yum install -y httpd.x86_64

# Start and enable Apache
systemctl start httpd.service
systemctl enable httpd.service

# Enable Server-Side Includes (SSI) in Apache
sed -i 's/#AddOutputFilter INCLUDES .shtml/AddOutputFilter INCLUDES .html/' /etc/httpd/conf/httpd.conf
sed -i 's/Options Indexes FollowSymLinks/Options Indexes FollowSymLinks Includes/' /etc/httpd/conf/httpd.conf

# Remove default Apache test page
rm -f /var/www/html/index.html /var/www/html/index.shtml

# Create the HTML file with instance details for HA Lab
cat << EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AWS High Availability Lab - ALB + EC2 Demo | Cloudboosta</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; min-height: 100vh; background: linear-gradient(to bottom, #1e3c72, #2a5298); color: white; display: flex; flex-direction: column; }
        .banner { background: #f39c12; color: #2c3e50; text-align: center; padding: 1rem; font-weight: bold; font-size: 1.2rem; }
        header { text-align: center; padding: 2rem; }
        main { flex-grow: 1; display: flex; flex-direction: column; align-items: center; padding: 2rem; }
        .instance-box { background: white; color: black; padding: 1.5rem; border-radius: 12px; font-size: 1.8rem; margin: 1rem; box-shadow: 0 4px 8px rgba(0,0,0,0.3); }
        .action-call { background: #27ae60; color: white; padding: 1rem 2rem; border-radius: 8px; margin: 2rem 0; text-align: center; font-weight: bold; font-size: 1.3rem; }
        .ha-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 2rem; width: 100%; max-width: 1200px; }
        .ha-card { background: rgba(255,255,255,0.1); padding: 1.5rem; border-radius: 12px; backdrop-filter: blur(10px); }
        .demo-steps { background: #e74c3c; color: white; padding: 1rem; border-radius: 8px; margin: 1rem 0; }
        footer { text-align: center; padding: 1rem; background: rgba(0,0,0,0.3); }
    </style>
</head>
<body>
    <div class="banner">🚀 Cloudboosta High Availability Lab</div>
    <header>
        <h1>AWS ALB + EC2 High Availability Demo</h1>
        <p>Watch load balancing in action!</p>
    </header>
    <main>
        <div class="instance-box">
            <strong>Current Instance:</strong><br>
            Hostname: <!--#exec cmd="hostname -f" --><br>
            Private IP: $PRIVATE_IP
        </div>
        <div class="action-call">
            🔄 REFRESH 5-10 TIMES → See IP change across instances!<br>
            PROOF: ALB distributes traffic for zero-downtime HA.
        </div>
        
        <div class="demo-steps">
            <h3>Lab Verification Steps</h3>
            <ol>
                <li>Access via <strong>ALB DNS</strong> (not direct EC2 IP)</li>
                <li>Refresh page → Traffic hits different EC2s</li>
                <li>Stop 1 instance → ALB routes around it instantly</li>
                <li>Scale up → ASG adds instances automatically</li>
            </ol>
        </div>

        <div class="ha-grid">
            <div class="ha-card">
                <h2>🎯 HA Core Principles</h2>
                <ul>
                    <li>Multi-AZ Deployment</li>
                    <li>Load Balancing (ALB)</li>
                    <li>Health Checks & Failover</li>
                    <li>Auto Scaling Groups</li>
                </ul>
            </div>
            <div class="ha-card">
                <h2>✅ Key Benefits</h2>
                <ul>
                    <li>99.99% Uptime SLA</li>
                    <li>Zero Manual Failover</li>
                    <li>Auto Scale on Demand</li>
                    <li>Fault-Tolerant Architecture</li>
                </ul>
            </div>
            <div class="ha-card">
                <h2>🛠️ Architecture</h2>
                <p>ALB → Target Group → EC2 ASG (2+ AZs)<br>
                Health checks ensure only healthy instances serve traffic.[web:1][web:11]</p>
            </div>
            <div class="ha-card">
                <h2>🚀 Pro Tips</h2>
                <ul>
                    <li>Use sticky sessions for stateful apps</li>
                    <li>Enable access logs for monitoring</li>
                    <li>Pair with RDS Multi-AZ</li>
                </ul>
            </div>
        </div>
    </main>
    <footer>
        <p>&copy; 2026 Cloudboosta Training Lab | Multi-AZ ALB Demo</p>
    </footer>
</body>
</html>
EOF

# Set correct file permissions
chmod 644 /var/www/html/index.html
chown apache:apache /var/www/html/index.html

# Restart Apache to apply changes
systemctl restart httpd.service
