module "vpc" {
  source          = "../../modules/vpc"
  env             = "dev"
  vpc_cidr        = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
  azs             = ["eu-central-1a", "eu-central-1b"]
}

module "ec2" {
  source         = "../../modules/ec2"
  env            = "dev"
  vpc_id         = module.vpc.vpc_id
  public_subnet  = module.vpc.public_subnets[0]
  private_subnet = module.vpc.private_subnets[0]
  my_ip          = "93.105.177.13/32"
  ami            = "ami-0669b163befffbdfc" # ubuntu 22.04 eu-central-1
  key_name       = module.ec2.key_name
}
