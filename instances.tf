#Data?
data "aws_ssm_parameter" "amazon2_linux"{
    name = var.ami_amazon2_linux
}

#Instances
resource "aws_instance" "nginx_EC2_TF_Public" {
  ami = nonsensitive(data.aws_ssm_parameter.amazon2_linux.value)
  instance_type = var.ec2_instance_type
  subnet_id = aws_subnet.terraform_PublicSubnet.id
  user_data = <<EOF
#! /bin/bash
sudo amazon-linux-extras install -y nginx1
sudo service nginx start
sudo rm /usr/share/nginx/html/index.html
echo '<html><head><title>Taco Team Server</title></head><body style=\"background-color:#1F778D\"><p style=\"text-align: center;\"><span style=\"color:#FFFFFF;\"><span style=\"font-size:28px;\">You did it! Have a &#127790;</span></span></p></body></html>' | sudo tee /usr/share/nginx/html/index.html
EOF
}

#Instances
resource "aws_instance" "nginx_EC2_TF_Private" {
  ami = nonsensitive(data.aws_ssm_parameter.amazon2_linux.value)
  instance_type = var.ec2_instance_type
  subnet_id = aws_subnet.terrafor_PriavateSubnet.id
  user_data = <<EOF
#! /bin/bash
sudo amazon-linux-extras install -y nginx1
sudo service nginx start
sudo rm /usr/share/nginx/html/index.html
echo '<html><head><title>Taco Team Server</title></head><body style=\"background-color:#1F778D\"><p style=\"text-align: center;\"><span style=\"color:#FFFFFF;\"><span style=\"font-size:28px;\">You did it! Have a &#127790;</span></span></p></body></html>' | sudo tee /usr/share/nginx/html/index.html
EOF
}