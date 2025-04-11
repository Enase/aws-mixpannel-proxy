variable "aws_region" {
  description = "AWS region"
  default     = "us-west-2"
}
variable "aws_access_key" {
  description = "AWS access key"
  type = string
  sensitive   = true
}
variable "aws_secret_key" {
  description = "AWS secret key"
  type = string
  sensitive   = true
}

variable "environment" {
  type = string
}

variable "log_retention_period" {
  type        = number
  default     = 7
  description = "Cloudwatch logs retention period"
}

variable "ssl_certificate" {
  type        = string
  default     = ""
  description = "SSL certificate ARN for the Mixpanel load balancer"
}

variable "as_max_size" {
  type        = number
  default     = 2
  description = "Max capacity for the EC2 auto-scaling group"
}

variable "as_desired_capacity" {
  type        = number
  default     = 1
  description = "Desired capacity for the EC2 auto-scaling group"
}

variable "ec2_instance_type" {
  type        = string
  default     = "t4g.small"
  description = "EC2 instance type the Mixpanel proxy will be running on"
}

variable "ecs_task_cpu" {
  type        = number
  default     = 1024
  description = "ECS Task CPU"
}

variable "ecs_task_memory" {
  type        = number
  default     = 1024
  description = "ECS Task Memory Reservation"
}

variable "ecr_container_image" {
  type        = string
  description = "ECR container image URI"
}
