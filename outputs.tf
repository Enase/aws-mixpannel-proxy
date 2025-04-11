output "alb_dns" {
  value       = module.alb.dns_name
  description = "Application Load Balancer DNS to access Mixpanel"
}

output "mixpanel_ecs_security_group_id" {
  value       = aws_security_group.ecs.id
  description = "Security Group Id of Mixpanel ECS"
}

output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}
