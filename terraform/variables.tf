variable "yandex_cloud_token" {
  type = string
}

variable "yandex_cloud_id" {
  type = string
}

variable "yandex_folder_id" {
  type = string
}

variable "lemp_image_id" {
  type = string
}

variable "zabbix_image_id" {
  type = string
  description = "debian 11"
}

variable "elasticsearch_image_id" {
  type = string
  description = "ubuntu 2204"
}

variable "kibana_image_id" {
  type = string
  description = "ubuntu 2204"

}

variable "bastion_image_id" {
  type = string
  default = "fd8781facvdr5090ovu6"
  description = "ubuntu 2204"
}