variable "region" {
  description = "The aws region. https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html"
  type        = string
  default     = "cn-northwest-1"
}

variable "availability_zones_count" {
  description = "The number of AZs."
  type        = number
  default     = 2
}

variable "project" {
  description = "Name to be used on all the resources as identifier. e.g. Project name, Application name"
  # description = "Name of the project deployment."
  type = string
  default = "roadClearance"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_bits" {
  description = "The number of subnet bits for the CIDR. For example, specifying a value 8 for this parameter will create a CIDR with a mask of /24."
  type        = number
  default     = 8
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    "Project"     = "TerraformEKSWorkshop"
    "Environment" = "Development"
    "Owner"       = "Ashish Patel"
  }
}

// VPC
variable "public-vpc-id" {
  description = "Public VPC Id"
}

variable "public-vpc-public-subnet-tags" {
  description = "Tags that identify the public subnets in the public VPC"
  type        = list(string)
}

variable "public-vpc-private-subnet-tags" {
  description = "Tags that identify the private subnets in the public VPC"
  type        = list(string)
}

variable "private-vpc-id" {
  description = "Private VPC Id"
}

variable "default-http-port" {
  description = "Default http port"
  default     = "80"
}

variable "aws-regions" {
  description = "A map "
  type        = map(string)
  default     = {
    "emea"    = "eu-west-1"
    "na"      = "us-east-1"
    "cn"      = "cn-northwest-1"
  }
}

variable "tfstate-aws-regions" {
  description = "AWS regions mapping"
  type        = map(string)
  default     = {
    "emea"    = "eu-west-1"
    "na"      = "us-east-1"
    "cn"      = "cn-northwest-1"
  }
}

variable "project-name" {
  description = "Project Name"
  default     = "rc"
}

variable "rc-region" {
  description = "RC-region to deploy."
  default 	  = "cn"
}

variable "addons" {
  type = list(object({
    name    = string
  }))

  default = [
    {
      name    = "kube-proxy"
    },
    {
      name    = "vpc-cni"
    },
    {
      name    = "coredns"
    }
  ]
}

locals {
  aws-domain         = var.rc-region == "cn" ? "amazonaws.com.cn" : "amazonaws.com"
  aws-region         = lookup(var.aws-regions, var.rc-region)
  resource-basename  = "bmw-lbs-${var.project-name}-${var.rc-region}"
  tfstate-aws-region = lookup(var.tfstate-aws-regions, var.rc-region)
  tags               = {
    "project"        = var.project-name
    "COST TAG 1"     = var.project-name
    "module"         = "roadClearance"
  }
}