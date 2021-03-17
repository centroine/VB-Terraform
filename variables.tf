########## Global ##########

variable "prefix" {
  type = string
  default = "lotus"
}

variable "default-tags" {
  type = map
  default = {
    Terraform: "True"
  }
}


########## VPC ##########

variable "vpc-cidr" {
  type = string
  default = "192.168.0.0/16"
}

variable "az" {
  type = list(string)
  default = ["ap-northeast-2a","ap-northeast-2c"]
}

variable "subnet-count"{
  type = string
  default = 2
}

variable "public-cidr" {
  type = list(string)
  default = ["192.168.0.0/24","192.168.1.0/24"]
}

variable "private-cidr" { 
  type = list(string)
  default = ["192.168.10.0/24","192.168.11.0/24"]
}

variable "db-cidr" { 
  type = list(string)
  default = ["192.168.20.0/24","192.168.21.0/24"]
}

variable "public-subnet-name" { 
  type = list(string)
  default = ["public-a","public-c"]
}

variable "private-subnet-name" { 
  type = list(string)
  default = ["private-a","private-c"]
}

variable "db-subnet-name" { 
  type = list(string)
  default = ["db-a","db-c"]
}


########## Application ##########

variable "app-port" {
  type = string
  default = 8080
}

variable "app-test-port" {
  type = string
  default = 8090
}

variable "fargate-cpu-web" {
  type = string
  default = "0.25vCPU"
}

variable "fargate-memory-web" {
  type = string
  default = "0.5GB"
}

variable "fargate-cpu-was" {
  type = string
  default = "0.25vCPU"
}

variable "fargate-memory-was" {
  type = string
  default = "0.5GB"
}

variable "image-web" {
  type = string
  default = "921176085839.dkr.ecr.ap-northeast-2.amazonaws.com/ms-nginx"
}

variable "image-was" {
  type = string
  default = "921176085839.dkr.ecr.ap-northeast-2.amazonaws.com/ms-nginx"
}