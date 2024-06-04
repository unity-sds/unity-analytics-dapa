resource "aws_ssm_parameter" "unity_dapa_health_check" {
  name  = join("/", ["/unity/healthCheck/shared-services", var.common_tags["Component"], "url"])
  type  = "String"
  value = join("", [aws_api_gateway_deployment.unit_rest_api_deployment.invoke_url, "/am-uds-dapa/health/processes"])
}
