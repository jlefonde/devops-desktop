packer {
  required_plugins {
    virtualbox = {
      version = "~> 1"
      source  = "github.com/hashicorp/virtualbox"
    }
    ansible = {
      version = "~> 1"
      source = "github.com/hashicorp/ansible"
    }
    vagrant = {
      version = "~> 1"
      source = "github.com/hashicorp/vagrant"
    }
  }
}

source "virtualbox-iso" "debian" {
  guest_os_type = "Debian_64"
  iso_url = var.iso_url
  iso_checksum = var.iso_checksum

  ssh_username = "vagrant"
  ssh_password = "vagrant"

  memory = 8192
  cpus = 4

  ssh_timeout = "10m"
  output_directory = var.output_directory

  gfx_controller = "vmsvga"
  gfx_vram_size = 128
  gfx_accelerate_3d = true
  shutdown_command = "echo 'vagrant' | sudo -S shutdown -P now"

  http_directory = var.http_directory
  boot_wait = "5s"
  boot_command = [
    "<esc><wait>",
    "install ",
    "auto=true ",
    "priority=critical ",
    "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
    "<enter><wait>"
  ]
}

build {
  name = "devops"
  sources = ["source.virtualbox-iso.debian"]

  provisioner "shell" {
    inline = [
      "echo 'vagrant ALL=(ALL:ALL) NOPASSWD:ALL' > /etc/sudoers.d/vagrant",
      "chmod 0440 /etc/sudoers.d/vagrant",
    ]
    execute_command = "echo 'vagrant' | {{ .Vars }} su -c '{{ .Path }}'"
  }

  provisioner "shell" {
    only = ["virtualbox-iso.debian"]
    script = "../scripts/install-vbox-guest-additions.sh"
    execute_command = "echo 'vagrant' | {{ .Vars }} su -c '{{ .Path }}'"
  }

  provisioner "ansible" {
    playbook_file = "../ansible/main.yml"
  }

  post-processor "vagrant" {
    output = "/home/jlefonde/goinfre/box/devops-{{.Provider}}.box"
  }
}
