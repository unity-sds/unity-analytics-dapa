resource "aws_ssm_parameter" "unity_dapa_health_check" {
  #name  = "/unity/healthCheck/shared-services/${var.common_tags[\"Component\"]}/url"
  #name  = "/unity/healthCheck/shared-services/process-mapper/url"
  name  = join("/", ["/unity/healthCheck/shared-services", var.common_tags["Component"], "url"])
  type  = "String"
  value = join("/", [aws_api_gateway_deployment.unit_rest_api_deployment.invoke_url, "/unity/v0/collections/MUR25-JPL-L4-GLOB-v4.2_analysed_sst/processes"])
}
