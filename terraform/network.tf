#----------Network-----------
resource "yandex_vpc_network" "network" {
  name = "network"
}

#---------Subnets-------------
resource "yandex_vpc_subnet" "subnet-zone-1" {
  name       = "subnet1"
  description = "for webserver 1"
  zone       = "ru-central1-a"
  network_id = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
  route_table_id = yandex_vpc_route_table.route-table.id
}

resource "yandex_vpc_subnet" "subnet-zone-2" {
  name       = "subnet2"
  description = "for webserver 2"
  zone       = "ru-central1-b"
  network_id = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.20.0/24"]
  route_table_id = yandex_vpc_route_table.route-table.id
}

resource "yandex_vpc_subnet" "subnet-private-technician" {
  name       = "subnet-private-technican"
  description = "for Elasticsearch"
  zone       = "ru-central1-b"
  network_id = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.30.0/24"]
  route_table_id = yandex_vpc_route_table.route-table.id
}

resource "yandex_vpc_subnet" "subnet-public-technician" {
  name       = "subnet-public-technican"
  description = "for Zabbix, Kibana and load balancer"
  zone       = "ru-central1-b"
  network_id = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.100.0/24"]
}

#----------------NAT-Gateway-----------------
resource "yandex_vpc_gateway" "nat-gateway" {
  name = "nat-gateway"
  folder_id = var.yandex_folder_id
  shared_egress_gateway {}
}

#--------------Route-table--------------------
resource "yandex_vpc_route_table" "route-table" {
  name = "route-table"
  folder_id = var.yandex_folder_id
  network_id = yandex_vpc_network.network.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id = yandex_vpc_gateway.nat-gateway.id
  }
}