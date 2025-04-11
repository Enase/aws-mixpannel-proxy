# ASG EC2 from ALB-sg
module "autoscaling_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${local.name}-lb-asg-ec2-http"
  description = "Autoscaling group security group"
  vpc_id      = module.vpc.vpc_id
  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.alb.security_group_id
    },
    {
      rule                     = "https-443-tcp"
      source_security_group_id = module.alb.security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 2
  egress_rules            = ["all-all"]
  tags                    = local.tags
}

# ECS-sg
resource "aws_security_group" "ecs" {
  name        = "${local.name}_outboud_ecs"
  description = "Allow traffic at Mixpanel ECS"
  vpc_id      = module.vpc.vpc_id
}
