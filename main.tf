module "network" {
  source   = "./modules/vpc"
  cidr_vpc = "10.0.0.0/16"
  cidr_public1 = "10.0.1.0/24"
  cidr_public2 = "10.0.2.0/24"
  cidr_private1 = "10.0.3.0/24"
  cidr_private2 = "10.0.4.0/24"
  az1 = "ap-northeast-1a"
  az2 = "ap-northeast-1c"
}

module "ec2" {
  source   = "./modules/ec2"
  ami                    = "ami-0cfc97bf81f2eadc4"
  instance_type          = "t2.micro"
  public_subnet_id       = module.network.public_subnet_id
  sg_id            = module.ec2-sg.sg_id
  iam_instance_profile   = module.iam_role.instanceprofile
}

module "ec2-sg" {
  source = "./modules/securitygroup"
  sg_config = {
    name        = "ec2-sg"
    vpc_id      = module.network.vpc_id
    protocol    = "tcp"
    port        = [22, 80, 443]
    cidr_blocks = ["10.0.0.0/16"]
  }
}
module "iam_role" {
  source = "./modules/iamrole"
  iam_role_name             = "tawa-role"
  iam_role_assume_role_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  }
  iam_role_policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

module alb_sg {
  source = "./modules/securitygroup_alb"
  alb_sg_config = {
    name        = "alb-sg"
    vpc_id      = module.network.vpc_id
    protocol    = "tcp"
    port        = [80]
    cidr_blocks = ["153.122.166.254/32"]
  }
}
module lb {
  source = "./modules/alb"
  security_groups = module.alb_sg.alb_sg_id
  target_id      =  [module.ec2.instance_id]
  lb_base_config = {
    public_subnet_id           = module.network.public_subnet_ids
    sg_id                      = module.alb_sg.alb_sg_id
    Name                    = "Tawa"
    enable_deletion_protection = false
  }
  lb_target_config = {
    port        = 80
    protocol    = "HTTP"
    vpc_id      = module.network.vpc_id
    path        = "/index.html"
    instance_id = module.ec2.instance_id
    }
    lb_listener_config = {
    port        = 80
    protocol    = "HTTP"
    vpc_id      = module.network.vpc_id
    path        = "/"
    instance_id = module.ec2.instance_id
  }
}


