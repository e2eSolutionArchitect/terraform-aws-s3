locals {
  data             = yamldecode(file("./config.yml"))
  resources = { for resource in local.data.s3 : resource.name => resource }
  tags = { for tag in local.data.tags : tag.project => tag }
}
