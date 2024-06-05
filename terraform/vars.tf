variable account_id {
  type = string
}

variable region {
  type = string
}

variable profile {
  type = string
}

variable docker_image_name {
  type = string
}

variable docker_image_tag {
  type = string
}

variable sdap_server_url_prefix {
  type = string
}

variable vpc_id {
  type = string
}

variable sg_id {
  type = string
}

variable role {
  type = string
}

variable subnet_id {
  type = string
}

variable subnet_ids {
  type = list
}

variable ami {
  type = string
}

#variable key_name {
#  type = string
#}

variable rest_api_name {
  type = string
}

variable rest_api_stage {
  type = string
}

variable parent_id {
  type = string
}

variable health_check_parent_id {
  type = string
}

variable common_tags {
  type = map
}
