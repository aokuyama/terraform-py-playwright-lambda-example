variable "region" {
  type    = string
  default = "ap-northeast-1"
}

variable "project_name" {
  type    = string
  default = "py-playwright-example"
}
variable "ecr_repository_name" {
  type    = string
  default = "py-playwright-example"
}
variable "tag_daploy" {
  type    = string
  default = "main"
}

variable "uri_repository" {
  type    = string
  default = "https://github.com/aokuyama/py-playwright_super_driver.git"
}
variable "branch-name_deploy" {
  type    = string
  default = "main"
}
