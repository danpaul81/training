provider "aws" {
	region 			= 	var.aws_region
}

resource "aws_vpc" "main" {
	cidr_block		= 	var.aws_cidr_vpc
	enable_dns_hostnames	= 	true
	enable_dns_support	= 	true
	tags = {
		Name 		= 	format("%s-vpc",var.prefix)
	}
}

resource "aws_subnet" "sn1" {
	vpc_id 			= 	aws_vpc.main.id
	cidr_block 		= 	var.aws_cidr_sn1
	
	tags = {
		Name	 	= 	format("%s-sn1",var.prefix)
		}
}		


resource "aws_internet_gateway" "igw" {
	vpc_id 			= 	aws_vpc.main.id
	tags = {
		Name 		= 	format("%s-igw",var.prefix)
	}
}

resource "aws_default_route_table" "rt" {
	default_route_table_id 	=	 aws_vpc.main.default_route_table_id
	route {
		cidr_block 	=	"0.0.0.0/0"
		gateway_id 	= 	aws_internet_gateway.igw.id
		}
	depends_on		= 	[aws_internet_gateway.igw]
}

# security group for demo server
resource "aws_security_group" "sg_default" {
	description 		= 	"Allow TCP 22 / 5000"
	vpc_id			= 	aws_vpc.main.id
	ingress {
		description 	= 	"SSH "
		from_port 	= 	22
		to_port 	= 	22
		protocol	= 	"tcp"
		cidr_blocks 	= 	["0.0.0.0/0"]
		}
	ingress {
		description	= 	"HTTP 5000"
		from_port 	=	5000
		to_port		=	5000
		protocol	=	"tcp"
		cidr_blocks	=	["0.0.0.0/0"]
		}
	egress {
		from_port   	= 	0
		to_port     	= 	0
		protocol    	= 	"-1"
		cidr_blocks 	= 	["0.0.0.0/0"]
		}
	tags = {
		Name 		= 	format("%s-SG-Default",var.prefix)
		}
}


resource "local_file" "cloud_init_yaml" {
  	for_each 		= toset(local.instances)
	content 		= templatefile("${path.module}/cloud-init.tpl", { 
	tpl-user 		= each.key
	tpl-access-key 		= var.ecr_access_key
	tpl-secret-access-key 	= var.ecr_secret_access_key	
	tpl-account-id		= var.aws_account_id
	tpl-region		= var.aws_region
	}
	)
	filename = "${path.module}/generated/cloud-init-${each.key}.yaml"
}

locals {
	instances = compact(split("\n",file("./users.txt")))
}

resource "aws_instance" "ec2vm" {
        for_each		=	toset(local.instances)
	ami 			=	var.aws_ami_image
	associate_public_ip_address = 	true
	instance_type		=	var.aws_instance_type
	root_block_device  {
		volume_size 	=	 8
	}
	vpc_security_group_ids 	=	[aws_security_group.sg_default.id]
	user_data_base64 = base64gzip(local_file.cloud_init_yaml[each.key].content)
	subnet_id		=	aws_subnet.sn1.id
	key_name 		= 	var.aws_key
	tags = {
		Name 		= 	format("%s-VM-%s",var.prefix,each.key)
	}
}

/*
output "public_ips" {
	value= aws_instance.ec2vm[*].public_ip
}
*/
