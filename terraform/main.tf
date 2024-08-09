provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_ecs_cluster" "main" {
  name = "prod-django-web-cluster"
}

resource "aws_ecs_task_definition" "web" {
  family                   = "my-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([{
    name      = "web"
    image     = "022499043855.dkr.ecr.us-east-1.amazonaws.com/django-web:prod-latest"
    cpu       = 256
    memory    = 512
    essential = true

    portMappings = [
      {
        containerPort = 8000
        hostPort      = 8000
        protocol      = "tcp"
      }
    ]

    environment = [
      {
        name  = "DEBUG"
        value = var.DEBUG
      },
      {
        name  = "DJANGO_ALLOWED_HOSTS"
        value = var.DJANGO_ALLOWED_HOSTS
      },
      {
        name  = "SQL_ENGINE"
        value = var.SQL_ENGINE
      },
      {
        name  = "SQL_DATABASE"
        value = var.SQL_DATABASE
      },
      {
        name  = "SQL_USER"
        value = var.SQL_USER
      },
      {
        name  = "SQL_PASSWORD"
        value = var.SQL_PASSWORD
      },
      {
        name  = "SQL_HOST"
        value = var.SQL_HOST
      },
      {
        name  = "SQL_PORT"
        value = var.SQL_PORT
      },
      {
        name  = "DATABASE"
        value = var.DATABASE
      },
      
    ]
  }])

  execution_role_arn = aws_iam_role.ecs_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_role.arn
}

resource "aws_ecs_service" "web" {
  name            = "web-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.web.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = ["subnet-0fd6d214ce0e1c9a2"]
    security_groups  = ["sg-0c385ddca1f9d4bfb"]
    assign_public_ip = true
  }
}

resource "aws_iam_role" "ecs_execution_role" {
  name = "ecs_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role     = aws_iam_role.ecs_execution_role.name
}

resource "aws_iam_role" "ecs_task_role" {
  name = "ecs_task_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# resource "aws_ecr_repository" "web" {
#   name = "django-web"
# }