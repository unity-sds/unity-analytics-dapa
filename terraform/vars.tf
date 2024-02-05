variable region {
  type = string
}

variable profile {
  type = string
}

variable vpc_id {
  type = string
}

variable sg_id {
  type = string
}

#data "aws_security_group" "uas_dev" {
#  vpc_id = var.vpc_id
#  id = var.sg_id
#}

variable role {
  type = string
}

variable subnet_id {
  type = string
}

variable key_name {
  type = string
}
