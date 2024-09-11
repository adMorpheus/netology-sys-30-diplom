output "bastion-host-external-ip" {
  value = "ssh administrator@${yandex_compute_instance.bastion-host.network_interface.0.nat_ip_address} -i ..\\ssh\\diploma_bastion"
}

output "load-balancer-external-ip" {
  value = "http://${yandex_alb_load_balancer.webserver-load-balancer.listener.0.endpoint.0.address.0.external_ipv4_address.0.address}/"
}

output "zabbix-external-address" {
  value = "http://${ yandex_compute_instance.zabbix-vm.network_interface.0.nat_ip_address }:8080/"
}

output "kibana-external-address" {
  value = "http://${yandex_compute_instance.kibana-vm.network_interface.0.nat_ip_address}:5601/"
}
#output "internal_ip_address_vm_1" {
#  value = yandex_compute_instance.web-server[*].network_interface.0.ip_address
#}
#

#output "bastion-ssh-connection-command" {
#  value = yandex_compute_instance.bastion-host.network_interface.0.nat_ip_address
#}
#output "ws-1-fqdn" {
#  value = yandex_compute_instance.web-server-01.fqdn
#}
#
#output "ws-2-fqdn" {
#  value = yandex_compute_instance.web-server-02.fqdn
#}
#
#output "ws-1-eip" {
#  value = yandex_compute_instance.web-server-01.network_interface.0.nat_ip_address
#}
#
#output "ws-2-eip" {
#  value = yandex_compute_instance.web-server-02.network_interface.0.nat_ip_address
#}
#

#ssh administrator@89.169.167.46 -i /home/administrator/.ssh/diploma_common