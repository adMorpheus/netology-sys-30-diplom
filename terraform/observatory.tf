# ----------Zabbix-vm-------------------
resource "yandex_compute_instance" "zabbix-vm" {
  name = "zabbix-vm"
  hostname = "zabbix"
  zone = "ru-central1-b"
  scheduling_policy {
    preemptible = true
  }

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = var.zabbix_image_id
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-public-technician.id
    nat = true
    security_group_ids = [yandex_vpc_security_group.private-sg.id,yandex_vpc_security_group.zabbix-sg.id]
  }
  metadata = {
    user-data = "${file("./cloud-init-common.yaml")}"
  }
}

# ------------------Elasticsearch-------------
resource "yandex_compute_instance" "elasticsearch-vm" {
  name="elasticsearch-vm"
  hostname = "elasticsearch"
  zone = "ru-central1-b"
  scheduling_policy {
    preemptible = true
  }
  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = var.elasticsearch_image_id
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-private-technician.id
    security_group_ids = [yandex_vpc_security_group.private-sg.id]
  }
  metadata = {
    user-data = "${file("./cloud-init-common.yaml")}"
  }
}

# ------------------Kibana-------------
resource "yandex_compute_instance" "kibana-vm" {
  name="kibana-vm"
  hostname = "kibana"
  zone = "ru-central1-b"
  scheduling_policy {
    preemptible = true
  }


  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = var.kibana_image_id
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-public-technician.id
    nat = true
    security_group_ids = [yandex_vpc_security_group.private-sg.id,yandex_vpc_security_group.kibana-sg.id]
  }
  metadata = {
    user-data = "${file("./cloud-init-common.yaml")}"
  }
}