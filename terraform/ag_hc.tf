resource "aws_api_gateway_resource" "unity_dapa_rest_api_health" {
  rest_api_id = data.aws_api_gateway_rest_api.unity_rest_api.id
  parent_id   = var.health_check_parent_id
  path_part   = "health"
}

resource "aws_api_gateway_resource" "unity_dapa_rest_api_health_processes" {
  rest_api_id = data.aws_api_gateway_rest_api.unity_rest_api.id
  parent_id   = aws_api_gateway_resource.unity_dapa_rest_api_health.id
  path_part   = "processes"
}

resource "aws_api_gateway_method" "unity_dapa_rest_api_health_processes_method" {
  rest_api_id = data.aws_api_gateway_rest_api.unity_rest_api.id
  resource_id   = aws_api_gateway_resource.unity_dapa_rest_api_health_processes.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "unity_dapa_rest_api_health_processes_integration" {
  rest_api_id = data.aws_api_gateway_rest_api.unity_rest_api.id
  resource_id   = aws_api_gateway_resource.unity_dapa_rest_api_health_processes.id
  http_method          = aws_api_gateway_method.unity_dapa_rest_api_health_processes_method.http_method
  #type                 = "HTTP"
  type                 = "HTTP_PROXY"
  uri                  = join("", ["http://", aws_lb.unity-dapa-lb.dns_name, "/unity/v0/openapi.json"])
  integration_http_method = "ANY"

  connection_type = "VPC_LINK"
  connection_id   = aws_api_gateway_vpc_link.unity_dapa_vpc_link.id

  #cache_key_parameters = ["method.request.path.proxy"]

  #timeout_milliseconds = 29000
  #request_parameters = {
  #}
}
