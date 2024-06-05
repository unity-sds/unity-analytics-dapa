data "template_file" "add_dapa" {
  template = file("add-dapa.sh.tpl")

  vars = {
    awsAccountId = var.account_id
    awsRegion = var.region
    dockerImageName = var.docker_image_name
    dockerImageTag = var.docker_image_tag
    sdapServerUrlPrefix = var.sdap_server_url_prefix
  }
}

resource "aws_iam_instance_profile" "unity_dapa_instance_profile" {
  name = "unity-dapa-instance-profile"

  role = var.role

  tags = {
    Name = "unity_dapa_instance_profile"
  }

}

resource "aws_instance" "unity_dapa_instance" {
  ami           = var.ami
  instance_type = "t2.micro"

  tags = {
    Name = "unity-dapa-instance"
  }

  #key_name = var.key_name

  vpc_security_group_ids = [var.sg_id]

  subnet_id = var.subnet_id

  iam_instance_profile = aws_iam_instance_profile.unity_dapa_instance_profile.name

  user_data = data.template_file.add_dapa.rendered
}
