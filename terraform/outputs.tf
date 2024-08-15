#output "internal_ip_address_vm_1" {
#  value = yandex_compute_instance.web-server[*].network_interface.0.ip_address
#}
#
#output "external_ip_address_vm_1" {
#  value = yandex_compute_instance.web-server[*].network_interface.0.nat_ip_address
#}
#
#output "webservers_ids" {
#  value = yandex_compute_instance.web-server[*].id
#}
#
#output "webservers_names" {
#  value = yandex_compute_instance.web-server[*].name
#}