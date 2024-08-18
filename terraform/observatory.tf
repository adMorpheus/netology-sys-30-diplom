# ----------Zabbix-vm-------------------
resource "yandex_compute_instance" "zabbix-vm" {
  name = "zabbix-vm"
  hostname = "zabbix"
  zone = "ru-central1-b"

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
    subnet_id = yandex_vpc_subnet.subnet-zone-2.id
    nat = true
  }
  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

# ------------------Elasticsearch-------------
resource "yandex_compute_instance" "elasticsearch-vm" {
  name="elasticsearch-vm"
  hostname = "elasticsearch"
  zone = "ru-central1-b"

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
    subnet_id = yandex_vpc_subnet.subnet-zone-2.id
  }
  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

# ------------------Kibana-------------
resource "yandex_compute_instance" "kibana-vm" {
  name="elasticsearch-vm"
  hostname = "kibana"
  zone = "ru-central1-b"

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
    subnet_id = yandex_vpc_subnet.subnet-zone-2.id
    nat = true
  }
  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}