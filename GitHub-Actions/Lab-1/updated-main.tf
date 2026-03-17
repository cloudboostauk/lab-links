cat << 'EOF' >> main.tf

# Enable versioning on the bucket
resource "aws_s3_bucket_versioning" "demo" {
  bucket = aws_s3_bucket.demo.id
  versioning_configuration {
    status = "Enabled"
  }
}
EOF
