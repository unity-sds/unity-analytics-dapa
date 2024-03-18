# Reference to the REST API to be updated
data "aws_api_gateway_rest_api" "unity_rest_api" {

  # Name of the REST API to look up. If no REST API is found with this name, an error will be returned. 
  # If multiple REST APIs are found with this name, an error will be returned. At the moment there is noi data source to 
  # get REST API by ID.
  #name = var.shared_services_rest_api_name
  name = var.unity_rest_api_name
}

resource "aws_api_gateway_resource" "unity_dapa_rest_api_collections" {
  rest_api_id = data.aws_api_gateway_rest_api.unity_rest_api.id
  parent_id   = var.parent_id
  path_part   = "collections"
}

#resource "aws_api_gateway_method" "unity_dapa_rest_api_collections_method" {
#  rest_api_id = data.aws_api_gateway_rest_api.unity_rest_api.id
#  resource_id   = aws_api_gateway_resource.unity_dapa_rest_api_collections.id
#  http_method   = "GET"
#  authorization = "NONE"
#}

resource "aws_api_gateway_resource" "unity_dapa_rest_api_collection_id" {
  rest_api_id = data.aws_api_gateway_rest_api.unity_rest_api.id
  parent_id   = aws_api_gateway_resource.unity_dapa_rest_api_collections.id
  path_part   = "{collectionId}"
}

#resource "aws_api_gateway_method" "unity_dapa_rest_api_collection_id_method" {
#  rest_api_id = data.aws_api_gateway_rest_api.unity_rest_api.id
#  resource_id   = aws_api_gateway_resource.unity_dapa_rest_api_collection_id.id
#  http_method   = "GET"
#  authorization = "NONE"
#  #request_parameters = {
#  #  "method.request.path.collectionId" = true
#  #}
#}

resource "aws_api_gateway_resource" "unity_dapa_rest_api_processes" {
  rest_api_id = data.aws_api_gateway_rest_api.unity_rest_api.id
  parent_id   = aws_api_gateway_resource.unity_dapa_rest_api_collection_id.id
  path_part   = "processes"
}

#resource "aws_api_gateway_method" "unity_dapa_rest_api_processes_method" {
#  rest_api_id = data.aws_api_gateway_rest_api.unity_rest_api.id
#  resource_id   = aws_api_gateway_resource.unity_dapa_rest_api_processes.id
#  http_method   = "GET"
#  authorization = "NONE"
#}

resource "aws_api_gateway_resource" "unity_dapa_rest_api_proxy_plus" {
  rest_api_id = data.aws_api_gateway_rest_api.unity_rest_api.id
  parent_id   = aws_api_gateway_resource.unity_dapa_rest_api_processes.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "unity_dapa_rest_api_proxy_plus_method" {
  rest_api_id = data.aws_api_gateway_rest_api.unity_rest_api.id
  resource_id   = aws_api_gateway_resource.unity_dapa_rest_api_proxy_plus.id
  http_method   = "ANY"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.collectionId" = true
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "unity_dapa_rest_api_proxy_plus_integration" {
  rest_api_id = data.aws_api_gateway_rest_api.unity_rest_api.id
  resource_id   = aws_api_gateway_resource.unity_dapa_rest_api_proxy_plus.id
  http_method          = aws_api_gateway_method.unity_dapa_rest_api_proxy_plus_method.http_method
  #type                 = "HTTP"
  type                 = "HTTP_PROXY"
  uri                  = join("", ["http://", aws_lb.unity-dapa-lb-tf.dns_name, "/unity/v0/collections/{collectionId}/processes/{proxy}"])
  integration_http_method = "ANY"

  connection_type = "VPC_LINK"
  connection_id   = data.aws_api_gateway_vpc_link.unity_dapa_vpc_link.id

  #cache_key_parameters = ["method.request.path.proxy"]

  #timeout_milliseconds = 29000
  request_parameters = {
    "integration.request.path.collectionId" = "method.request.path.collectionId",
    "integration.request.path.proxy" = "method.request.path.proxy"
  }

}

# 
# Creates the project API Gateway resource to be pointed to a project level API gateway.
# DEPLOYER SHOULD MODIFY THE VARIABLE var.resource_for_project TO BE THE PROJECT NAME (e.g. "soundersips")
resource "aws_api_gateway_resource" "unity_dapa_rest_api_resource" {
  rest_api_id = data.aws_api_gateway_rest_api.unity_rest_api.id
  #rest_api_id = var.rest_api_id
  parent_id   = var.parent_id
  path_part   = var.path_part
}

#resource "aws_api_gateway_method" "unity_dapa_rest_api_resource_method" {
#  rest_api_id = data.aws_api_gateway_rest_api.unity_rest_api.id
#  #rest_api_id   = var.rest_api_id
#  resource_id   = aws_api_gateway_resource.unity_dapa_rest_api_resource.id
#  http_method   = "GET"
#  authorization = "NONE"
#  #request_parameters = {
#  #  "method.request.path.proxy" = true
#  #}
#}

#
# Creates the wildcard path (proxy+) resource, under the project resource 
#
resource "aws_api_gateway_resource" "unity_dapa_rest_api_proxy_resource" {
  rest_api_id = data.aws_api_gateway_rest_api.unity_rest_api.id
  #rest_api_id = var.rest_api_id
  parent_id   = aws_api_gateway_resource.unity_dapa_rest_api_resource.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "unity_dapa_rest_api_proxy_resource_method" {
  rest_api_id = data.aws_api_gateway_rest_api.unity_rest_api.id
  #rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.unity_dapa_rest_api_proxy_resource.id
  http_method   = "ANY"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

data "aws_api_gateway_vpc_link" "unity_dapa_vpc_link" {
  name        = "unity-dapa-vpclink-test"
}

resource "aws_api_gateway_integration" "unity_dapa_rest_api_proxy_resource_integration" {
  rest_api_id = data.aws_api_gateway_rest_api.unity_rest_api.id
  resource_id   = aws_api_gateway_resource.unity_dapa_rest_api_proxy_resource.id
  http_method          = aws_api_gateway_method.unity_dapa_rest_api_proxy_resource_method.http_method
  #type                 = "HTTP"
  type                 = "HTTP_PROXY"
  uri                  = "http://www.example.net"
  integration_http_method = "ANY"

  connection_type = "VPC_LINK"
  connection_id   = data.aws_api_gateway_vpc_link.unity_dapa_vpc_link.id

  #cache_key_parameters = ["method.request.path.proxy"]

  #timeout_milliseconds = 29000
  request_parameters = {
    #"integration.request.path.collectionId" = "method.request.path.collectionId",
    "integration.request.path.proxy" = "method.request.path.proxy"
  }

}

resource "aws_api_gateway_deployment" "unit_rest_api_deployment" {
  rest_api_id = data.aws_api_gateway_rest_api.unity_rest_api.id
  #stage_name  = var.rest_api_stage
  stage_name  = "beta"
}

/*

resource "aws_api_gateway_vpc_link" "unity_dapa_vpc_link" {
  name        = "unity-dapa--vpc-link"
  target_arns = [aws_lb.unity-dapa-lb-tf.arn]
}

resource "aws_api_gateway_integration" "rest_api_resource_for_project_proxy_resource_method_integration" {
  rest_api_id   = data.aws_api_gateway_rest_api.rest_api.id
  resource_id          = aws_api_gateway_resource.rest_api_resource_for_project_proxy_resource.id
  http_method          = aws_api_gateway_method.rest_api_resource_for_project_proxy_resource_method.http_method
  type                 = "HTTP_PROXY"
  uri                  = var.project_leveL_rest_api_integration_uri
  integration_http_method = "ANY"

  cache_key_parameters = ["method.request.path.proxy"]

  timeout_milliseconds = 29000
  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }

}

resource "aws_api_gateway_method" "rest_api_get_options_method" {
  rest_api_id   = data.aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.rest_api_resource_for_project.id
  http_method   = "OPTIONS"
  authorization = "NONE"
  request_parameters = {"method.request.header.Authorization" = true}
}

resource "aws_api_gateway_integration" "sample_rest_api_get_method_integration" {
  rest_api_id = data.aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.rest_api_resource_for_project.id
  http_method = aws_api_gateway_method.rest_api_get_options_method.http_method

  type        = "MOCK"
}

# The Shared Services API Gateway deployment
resource "aws_api_gateway_deployment" "shared_services_api_gateway_deployment" {
  rest_api_id = data.aws_api_gateway_rest_api.rest_api.id
  stage_name        = var.rest_api_stage
  stage_description = "Deployed at ${timestamp()}"

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [ aws_api_gateway_integration.rest_api_resource_for_project_proxy_resource_method_integration ]
}
*/



# The following section is commented out, because it is not required for RESTful APIs

/*
# Sample Website Proxy
resource "aws_api_gateway_resource" "sample_website" {
  rest_api_id = data.aws_api_gateway_rest_api.rest_api.id
  parent_id   = data.aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part   = "sample_website"
}

resource "aws_api_gateway_method" "sample_website_get_method" {
  rest_api_id   = data.aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.sample_website.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "sample_website_get_method_integration" {
  rest_api_id = data.aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.sample_website.id
  http_method = aws_api_gateway_method.sample_website_get_method.http_method

  type                    = "HTTP"
  uri                     = var.sample_website_integration_uri
  integration_http_method = "GET"
}

resource "aws_api_gateway_method_response" "sample_website_get_method_response_200" {
  rest_api_id = data.aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.sample_website.id
  http_method = aws_api_gateway_method.sample_website_get_method.http_method
  status_code = "200"

  response_models = {
    "text/html" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "sample_website_get_method_integration_response" {
  rest_api_id = data.aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.sample_website.id
  http_method = aws_api_gateway_method.sample_website_get_method.http_method
  status_code = aws_api_gateway_method_response.sample_website_get_method_response_200.status_code

  response_templates = {"text/html": "$input.path('$')"}
}

resource "aws_api_gateway_deployment" "api-gateway-deployment" {
  rest_api_id = data.aws_api_gateway_rest_api.rest_api.id
  stage_name  = var.rest_api_stage
}

*/
