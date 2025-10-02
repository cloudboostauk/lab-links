terraform {
  backend "s3" {
    bucket         = "myterraform-bucket-safe" # Replace with your actual bucket name
    key            = "terraform.tfstate"
    region         = "eu-west-2" # Change to thesame region your bucket was created
    use_lockfile   = true
  }
}