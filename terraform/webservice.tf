#----------Webservers--------------

resource "yandex_compute_instance" "web-server-01" {
  name     = "web-server-01"
  hostname = "webserver01"
  zone     = "ru-central1-a"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.lemp_image_id
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet-zone-1.id
    security_group_ids = [yandex_vpc_security_group.private-sg.id]
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }

}

resource "yandex_compute_instance" "web-server-02" {
  name     = "web-server-02"
  hostname = "webserver02"
  zone     = "ru-central1-b"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.lemp_image_id
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet-zone-2.id
    security_group_ids = [yandex_vpc_security_group.private-sg.id]
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }

}

#----------Webservers-target-group-------------

resource "yandex_alb_target_group" "webservers-target-group" {
  name = "webservers-target-group"
  target {
    subnet_id  = yandex_vpc_subnet.subnet-zone-1.id
    ip_address = yandex_compute_instance.web-server-01.network_interface.0.ip_address
  }

  target {
    subnet_id  = yandex_vpc_subnet.subnet-zone-2.id
    ip_address = yandex_compute_instance.web-server-02.network_interface.0.ip_address
  }

}

#----------Webservers-backend-group-------------
resource "yandex_alb_backend_group" "webservers-backend-group" {
  name = "webservers-backend-group"
  http_backend {
    name             = "webservers-http-backend"
    weight           = 1
    port             = 80
    target_group_ids = [yandex_alb_target_group.webservers-target-group.id]
    healthcheck {
      interval = "1s"
      timeout  = "1s"
      http_healthcheck {
        path = "/"
      }
    }
  }
}

#----------Webservers-HTTP-router-------------
resource "yandex_alb_http_router" "webservers-http-router" {
  name = "webservers-http-router"

}

#----------Webservers-virtual-host-------------
resource "yandex_alb_virtual_host" "webservers-virtual-host" {
  name           = "webservers-virtual-host"
  http_router_id = yandex_alb_http_router.webservers-http-router.id
  route {
    name = "webservers-route"
    http_route {
      http_match {
        path {
          prefix = "/"
        }
      }
      http_route_action {
        backend_group_id = yandex_alb_backend_group.webservers-backend-group.id
        timeout          = "3s"
      }
    }
  }
}

#----------Webservers-load-balancer-------------
resource "yandex_alb_load_balancer" "webserver-load-balancer" {
  name               = "webserver-load-balancer"
  network_id         = yandex_vpc_network.network.id
  security_group_ids = [yandex_vpc_security_group.private-sg.id, yandex_vpc_security_group.load-balancer-sg.id]
  allocation_policy {
    location {
      subnet_id = yandex_vpc_subnet.subnet-public-technician.id
      zone_id   = "ru-central1-b"
    }
  }
  listener {
    name = "webservers-listener"
    endpoint {
      ports = [80]
      address {
        external_ipv4_address {

        }
      }
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.webservers-http-router.id
      }
    }
  }
}