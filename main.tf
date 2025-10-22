resource "aws_s3_bucket" "test_bucket" {
  bucket = "test-bucket-${random_id.suffix.hex}"

  tags = {
    Name        = "Test bucket"
    Environment = "dev"
  }
}

resource "random_id" "suffix" {
  byte_length = 4

}

