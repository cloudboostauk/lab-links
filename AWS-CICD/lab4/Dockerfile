# Use a slim Python 3.11 base image
FROM public.ecr.aws/docker/library/python:3.11-slim

# Set a working directory inside the container
WORKDIR /app

# Copy dependencies first — Docker caches this layer if requirements.txt is unchanged
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
# Copy the application code
COPY app.py .

# Expose port 5000
EXPOSE 5000

# Run with gunicorn: 2 workers, binding to all interfaces on port 5000
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "app:app"]
