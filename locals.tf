locals {
  common_tags = {
    company = var.company
    project = "${var.company} - ${var.billing_code}"
    billing_code = var.billing_code

  }
  s3_bucket_name = "globo-web-app-${random_integer.s3_random_number.result}"
}


#Random Integer 
resource "random_integer" "s3_random_number" {
  min = 10000
  max = 999999
}