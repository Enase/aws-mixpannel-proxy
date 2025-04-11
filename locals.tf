locals {
  name   = "mixpanel-${local.environment}"
  environment = var.environment
  aws_region = var.aws_region
  vpc_cidr = "10.0.0.0/16"
  azs_count = 3
  azs      = slice(data.aws_availability_zones.available.names, 0, local.azs_count)

  container = {
    name        = "mixpanel"
    image       = var.ecr_container_image
    image_tag   = "7"
    container_port = 80
  }

  tags = {
    Terraform = "true"
    Source = local.name
    Environment = local.environment
  }
}
