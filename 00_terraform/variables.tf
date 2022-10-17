variable "aws_region" {
description ="AWS region"
	type		= string
	default 	= "eu-west-1"
}

variable "aws_cidr_vpc" {
	description ="CIDR block for VPC"
	type		= string
	default 	= "172.30.0.0/16"
}

variable "aws_cidr_sn1" {
	description ="CIDR block for Subnet1"
	type		= string
	default 	= "172.30.1.0/24"
}

variable "aws_ami_image" {
	description ="AMI Image to use EC2 VMs"
	type		= string
	default 	= "ami-0ea0f26a6d50850c5" #aws linux x64
}

variable "aws_instance_type" {
	description ="AWS Instance Type"
	type		= string
	default 	= "t2.micro"
}

variable "aws_key" {
 	description = "pre-defined ssh key"
	type 	    = string
	default     = "dpaul-key"
}

variable "prefix" {
	description 	= "naming prefix"
	type 		= string
}

variable "ecr_access_key" {
	description 	= "aws access credentials used for ecr"
	type		= string
}

variable "ecr_secret_access_key" {
	description	= "aws secret used for ecr"
	type 		= string
}

variable "aws_account_id" {
	description 	= "aws account id"
	type		= string
}
