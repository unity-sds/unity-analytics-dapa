output "instance_id" {
  value = aws_instance.unity_dapa_instance.id
}

output "instance_public_dns" {
  value = aws_instance.unity_dapa_instance.public_dns
}

output "instance_tags_all" {
  value = aws_instance.unity_dapa_instance.tags_all
}

output "api_gateway_invoke_url" {
  value = aws_api_gateway_deployment.unit_rest_api_deployment.invoke_url
}

output "api_gateway_vpc_link" {
  value = data.aws_api_gateway_vpc_link.unity_dapa_vpc_link.id
}

