module "ecs_service" {
  source = "terraform-aws-modules/ecs/aws//modules/service"

  name        = "${local.name}-svc"
  cluster_arn = module.ecs_cluster.arn
  cpu         = var.ecs_task_cpu
  memory      = var.ecs_task_memory
  network_mode = "awsvpc"

  enable_autoscaling = true

  runtime_platform = {
    "cpu_architecture" : "ARM64",
    "operating_system_family" : "LINUX"
  }

  requires_compatibilities = ["EC2"]
  capacity_provider_strategy = {
    # On-demand instances
    mp_1 = {
      capacity_provider = module.ecs_cluster.autoscaling_capacity_providers["mp_1"].name
      weight            = 1
      base              = 1
    }
  }

  # Container definition(s)
  container_definitions = {
    (local.container.name) = {
      image = "${local.container.image}:${local.container.image_tag}"
      essential   = true
      port_mappings = [
        {
          name          = local.container.name
          containerPort = local.container.container_port
          hostPort      = local.container.container_port
          protocol      = "tcp"
        }
      ]
      health_check = {
        command = [
          "CMD-SHELL",
          "curl --fail -I http://localhost:${local.container.container_port}/health-check || exit 1"
        ]
      }
      readonly_root_filesystem = false

      enable_cloudwatch_logging              = true
      create_cloudwatch_log_group            = true
      cloudwatch_log_group_name              = "/aws/ecs/${local.name}/${local.container.name}"
      cloudwatch_log_group_retention_in_days = var.log_retention_period

      log_configuration = {
        logDriver = "awslogs"
      }
    }
  }

  load_balancer = {
    service = {
      target_group_arn = module.alb.target_groups["ex_ecs"].arn
      container_name   = local.container.name
      container_port   = local.container.container_port
    }
  }

  subnet_ids          = module.vpc.private_subnets
  security_group_name = "${local.name}-lb-to-ecs-container-port"
  security_group_rules = {
    alb_http_ingress = {
      type                     = "ingress"
      from_port                = local.container.container_port
      to_port                  = local.container.container_port
      protocol                 = "tcp"
      description              = "Service port"
      source_security_group_id = module.alb.security_group_id
    }
    egress_all = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  security_group_ids = [aws_security_group.ecs.id]

  tags = local.tags
}
