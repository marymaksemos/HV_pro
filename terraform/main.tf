provider "google" {
  credentials = file("/home/zakaria/HV_pro/firstproject-402512-ce5d7b6f58d1.json")
  project     = "firstproject-402512"
  region      = "europe-north1"
}

resource "google_compute_instance" "web" {
  count        = 2
  name         = "nginx-web-${count.index}"
  machine_type = "t2d-standard-1"
  zone         = "europe-north1-${element(["b", "c"], count.index)}" 

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }

 metadata = {
  "ssh-keys" = "mary:${file("~/.ssh/id_rsa.pub")}"
}



}
resource "google_compute_instance" "nginx-lb" {
  name         = "nginx-lb"
  machine_type = "t2d-standard-1"
  zone         = "europe-north1-a"  

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    "ssh-keys" = "mary:${file("~/.ssh/id_rsa.pub")}"
  }
}

output "instance_ips" {
  value = [for instance in google_compute_instance.web : instance.network_interface[0].access_config[0].nat_ip]
  description = "The external IP addresses of the web instances"
}

output "lb_ip" {
  value       = google_compute_instance.nginx-lb.network_interface[0].access_config[0].nat_ip
  description = "The external IP address of the NGINX load balancer"
}

resource "google_compute_firewall" "allow_http_https" {
  name    = "allow-http-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  description   = "Allow traffic on ports 80 and 443"
}

