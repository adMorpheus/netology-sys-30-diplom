#----------Network-----------
resource "yandex_vpc_network" "network" {
  name = "network"
}

resource "yandex_vpc_subnet" "subnet-zone-1" {
  name       = "subnet1"
  description = "for webserver 1"
  zone       = "ru-central1-a"
  network_id = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "subnet-zone-2" {
  name       = "subnet2"
  description = "for webserver 2"
  zone       = "ru-central1-b"
  network_id = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.20.0/24"]
}

resource "yandex_vpc_subnet" "subnet-private-technician" {
  name       = "subnet2"
  description = "for webserver 2"
  zone       = "ru-central1-b"
  network_id = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.30.0/24"]
}

resource "yandex_vpc_subnet" "subnet-public-technician" {
  name       = "subnet2"
  description = "for webserver 2"
  zone       = "ru-central1-b"
  network_id = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.100.0/24"]
}

