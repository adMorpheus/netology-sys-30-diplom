resource "yandex_compute_snapshot_schedule" "backup" {
  name = "backup"

  schedule_policy {
    expression = "0 0 * * *"
  }

  snapshot_count = 7

  snapshot_spec {
    description = "daily"
  }

  disk_ids = [yandex_compute_instance.web-server-01.boot_disk[0].disk_id,
    yandex_compute_instance.web-server-02.boot_disk[0].disk_id,
    yandex_compute_instance.zabbix-vm.boot_disk[0].disk_id,
    yandex_compute_instance.elasticsearch-vm.boot_disk[0].disk_id,
    yandex_compute_instance.kibana-vm.boot_disk[0].disk_id,
    yandex_compute_instance.bastion-host.boot_disk[0].disk_id]
}