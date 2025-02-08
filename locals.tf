locals {
  common_tags = {
    company = var.company
    project = "${var.company} - ${var.billing_code}"
    billing_code = var.billing_code

  }

}