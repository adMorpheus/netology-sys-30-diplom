#output "internal_ip_address_vm_1" {
#  value = yandex_compute_instance.web-server[*].network_interface.0.ip_address
#}
#
output "ws-1-fqdn" {
  value = yandex_compute_instance.web-server-01.fqdn
}

output "ws-2-fqdn" {
  value = yandex_compute_instance.web-server-02.fqdn
}

output "ws-1-eip" {
  value = yandex_compute_instance.web-server-01.network_interface.0.nat_ip_address
}

output "ws-2-eip" {
  value = yandex_compute_instance.web-server-02.network_interface.0.nat_ip_address
}

output "zabbix-external-ip" {
  value = yandex_compute_instance.zabbix-vm.network_interface.0.nat_ip_address
}
#
# output "load-balancer-external-ip" {
#   value = yandex_alb_load_balancer.webserver-load-balancer.listener.0.endpoint.address