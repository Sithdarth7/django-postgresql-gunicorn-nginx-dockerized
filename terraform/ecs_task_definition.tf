resource "aws_ecs_task_definition" "web" {
  family                   = "my-web-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "web"
      image     = "http://localhost:4566/my-web-repo:latest"
      cpu       = 256
      memory    = 512
      essential = true

      command = [
        "python",
        "manage.py",
        "runserver",
        "0.0.0.0:8000"
      ]

      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
          protocol      = "tcp"
        }
      ]

      environment = [
        {
          name  = "POSTGRES_USER"
          value = "hello_django"
        },
        {
          name  = "POSTGRES_PASSWORD"
          value = "hello_django"
        },
        {
          name  = "POSTGRES_DB"
          value = "hello_django_dev"
        }
      ]

      mountPoints = [
        {
          sourceVolume  = "app-data"
          containerPath = "/usr/src/app"
        }
      ]
    }
  ])

  volume {
    name = "app-data"
  }
}

resource "aws_ecs_task_definition" "db" {
  family                   = "my-db-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "db"
      image     = "http://localhost:4566/my-db-repo:latest"
      cpu       = 256
      memory    = 512
      essential = true

      environment = [
        {
          name  = "POSTGRES_USER"
          value = "hello_django"
        },
        {
          name  = "POSTGRES_PASSWORD"
          value = "hello_django"
        },
        {
          name  = "POSTGRES_DB"
          value = "hello_django_dev"
        }
      ]

      mountPoints = [
        {
          sourceVolume  = "postgres-data"
          containerPath = "/var/lib/postgresql/data"
        }
      ]
    }
  ])

  volume {
    name = "postgres-data"
  }
}
