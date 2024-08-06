# This is commented due to localstack is not supported on community version
# resource "aws_ecr_repository" "web" {
#   name                 = "https://aws_account_id.dkr.ecr.region.amazonaws.com/django-web:latest"
#   image_tag_mutability = "MUTABLE"
#   image_scanning_configuration {
#     scan_on_push = true
#   }
# }

# resource "aws_ecr_repository" "db" {
#   name                 = "https://aws_account_id.dkr.ecr.region.amazonaws.com/db-postgres:latest"
#   image_tag_mutability = "MUTABLE"
#   image_scanning_configuration {
#     scan_on_push = true
#   }
# }

# resource "aws_ecr_repository" "nginx" {
#   name                 = "https://aws_account_id.dkr.ecr.region.amazonaws.com/rp-nginx:latest"
#   image_tag_mutability = "MUTABLE"
#   image_scanning_configuration {
#     scan_on_push = true
#   }
# }
