cat << 'EOF' > Dockerfile.frontend
FROM python:3.11-slim

WORKDIR /app

RUN pip install flask requests

COPY frontend-app.py app.py

EXPOSE 3000

CMD ["python", "app.py"]
EOF
