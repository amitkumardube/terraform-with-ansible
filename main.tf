resource "google_compute_instance" "default" {
  count = var.vm_required ? length(var.vm_names) : 0
  name = var.vm_names[count.index]
  machine_type = "f1-micro"
  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  // Local SSD disk
/*   scratch_disk {
    interface = "SCSI"
  } */

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    ssh-keys = "amitkumardube:${file("id_rsa.pub")}"
  }

  provisioner "remote-exec" {
    inline = ["echo 'Hello World'"]

    connection {
        type        = "ssh"
        user        = "amitkumardube"
        host        = self.network_interface[0].access_config[0].nat_ip
        private_key = file("id_rsa")
    }
}

    provisioner "local-exec" {
        command = "ansible-playbook -i '${self.network_interface[0].access_config[0].nat_ip}' playbook.yaml"
    }

}