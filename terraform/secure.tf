# --------Bastion-host--------

resource "yandex_compute_instance" "bastion-host" {
  name     = "bastion-host"
  hostname = "bastion"
  zone     = "ru-central1-b"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.bastion_image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-public-technician.id
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }

}


# ---------Private-network--------------------------
resource "yandex_vpc_security_group" "private-sg" {
  name       = "private-sg"
  network_id = yandex_vpc_network.network.id

  ingress {
    protocol = "ANY"
    v4_cidr_blocks = ["192.168.10.0/24", "192.168.20.0/24", "192.168.30.0/24", "192.168.100.0/24"]
  }

  egress {
    protocol = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

#------------------Secure-group-for-load-balancer-------------------
resource "yandex_vpc_security_group" "load-balancer-sg" {
  name       = "load-balancer-secure-group"
  network_id = yandex_vpc_network.network.id

  ingress {
    protocol = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port     = 80
  }

  egress {
    protocol = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

#------------------Secure-group-for-bastion-host-------------------
resource "yandex_vpc_security_group" "bastion-host-sg" {
  name       = "bastion-host-secure-group"
  network_id = yandex_vpc_network.network.id


  ingress {
    protocol = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port     = 22
  }

  egress {
    protocol = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

#------------------Secure-group-for-zabbix-------------------
resource "yandex_vpc_security_group" "zabbix-sg" {
  name       = "zabbix-sg"
  network_id = yandex_vpc_network.network.id

  ingress {
    protocol = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port     = 8080
  }

  egress {
    protocol = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

#------------------Secure-group-for-kibana-------------------
resource "yandex_vpc_security_group" "kibana-sg" {
  name       = "kibana-sg"
  network_id = yandex_vpc_network.network.id

  ingress {
    protocol = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port     = 5601
  }

  egress {
    protocol = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
