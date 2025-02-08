#Providers
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.84.0"
    }
  }
}
provider "aws" {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
    region = var.aws_region
  
}


#Resources 
#VPC
resource "aws_vpc" "terraform_VPC" {
    cidr_block = var.vpc_cidr_block
    enable_dns_hostnames = true
    tags = local.common_tags
  
}

#Internet Gateway
resource "aws_internet_gateway" "terraform_IGTW" {
  vpc_id = aws_vpc.terraform_VPC.id
}


#Public Subnet
resource "aws_subnet" "terraform_PublicSubnet" {
  cidr_block =  var.vpc_public_subnet_cidr_block[0]
  vpc_id = aws_vpc.terraform_VPC.id
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[0]
}
#Public Subnet
resource "aws_subnet" "terraform_PrivateSubnet" {
  cidr_block =  var.vpc_public_subnet_cidr_block[1]
  vpc_id = aws_vpc.terraform_VPC.id
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[0]
}

#DATA
data "aws_availability_zones" "available" {
  state = "available"
}

#Routing
resource "aws_route_table" "Terraform_RouteTable" {
  vpc_id = aws_vpc.terraform_VPC.id
  route{
    cidr_block = var.route_table_cidr_block
    gateway_id = aws_internet_gateway.terraform_IGTW.id
  }

}

resource "aws_route_table_association" "terraform_RouteTA_Public" {
    subnet_id = aws_subnet.terraform_PublicSubnet.id
    route_table_id = aws_route_table.Terraform_RouteTable.id
  
}
resource "aws_route_table_association" "terraform_RouteTA_Private" {
    subnet_id = aws_subnet.terraform_PrivateSubnet.id
    route_table_id = aws_route_table.Terraform_RouteTable.id
  
}

#Security Groups
#Nginx
resource "aws_security_group" "Terraform_Nginx_SG" {
  name = "Nginx_Security_Group_TF"
  description = "Security Group Nginx Created with Terraform"
  vpc_id = aws_vpc.terraform_VPC.id
}
resource "aws_vpc_security_group_ingress_rule" "TF_Ingress_Nginx_SG" {
  security_group_id = aws_security_group.Terraform_Nginx_SG.id
  cidr_ipv4 = var.route_table_cidr_block
  from_port = var.http_port_cidr_block
  to_port = var.http_port_cidr_block
  ip_protocol = var.tcp_protocol
}

resource "aws_vpc_security_group_egress_rule" "TF_Ingress_Nginx_SG" {
  security_group_id = aws_security_group.Terraform_Nginx_SG.id
  cidr_ipv4 = var.route_table_cidr_block
  ip_protocol = var.allow_all_outbound
  
}

