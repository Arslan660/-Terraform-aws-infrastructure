resource "aws_s3_bucket" "main" {
  bucket = "${var.project_name}-bucket-${var.bucket_suffix}"

  tags = {
    Name = "${var.project_name}-bucket"
  }
}