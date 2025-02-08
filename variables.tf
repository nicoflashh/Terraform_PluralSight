# Variable "name_label" {
#   type = value
#   description = string ""
#   default = value
#   sensitive = true/false
#}
#var.<name_label>

variable "aws_access_key" {
    type = string
    description = "AWS access Keys"
    sensitive = true
  
}

variable "aws_secret_key" {
    type = string
    description = "AWS secret Keys"
    sensitive = true
  
}

variable "aws_region" {
    type = string
    description = "AWS Region"
    default =  "eu-west-1" 
}
variable "ami_amazon2_linux" {
    type = string
    default = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
  
}
variable "vpc_cidr_block" {
    type = string
    description = "VPC Cidr Block"
    default = "10.0.0.0/16"
}
variable "vpc_public_subnet_cidr_block" {
    type = list(string)
    description = "Public SUbnet Cidr Block"
    default = ["10.0.0.0/24", "10.0.1.0/24"]
}


variable "route_table_cidr_block" {
    type = string
    description = "Route Table Cidr Block"
    default = "0.0.0.0/0"
}

variable "http_port_cidr_block" {
    type = number
    description = "HTTP Port"
    default = 80
}
variable "tcp_protocol" {
    type = string
    description = "TCP protocol"
    default = "tcp"
  
}
variable "allow_all_outbound" {
    type = string
    description = "Allow all traffic"
    default = "-1"
  
}

variable "ec2_instance_type" {
    type = string
    description = "Instance Type"
    default = "t3.micro"
  
}
#Local variables 
variable "company" {
  type        = string
  description = "Company name for resource tagging"
  default     = "Tusmu3rt0s"
}

variable "project" {
  type        = string
  description = "Project name for resource tagging"
}

variable "billing_code" {
  type        = string
  description = "Billing code for resource tagging"
}
