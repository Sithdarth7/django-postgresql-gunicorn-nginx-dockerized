output "ecs_cluster_id" {
  value = aws_ecs_cluster.main.id
}

output "web_service_name" {
  value = aws_ecs_service.web.name
}

output "db_service_name" {
  value = aws_ecs_service.db.name
}

output "load_balancer_dns_name" {
  value = aws_lb.main.dns_name
}
