packer {
    required_plugins {
        virtualbox = {
          version = "~> 1"
          source  = "github.com/hashicorp/virtualbox"
        }
    }
}

source "virtualbox-iso" "debian" {
  vm_name = var.name
  guest_os_type = "Debian_64"
  iso_url = var.iso_url
  iso_checksum = var.iso_checksum

  ssh_username = var.username
  ssh_password = var.user_password

  memory = 8192
  cpus = 4

  ssh_timeout = "10m"
  output_directory = var.output_directory

  shutdown_command = "echo '${var.user_password}' | sudo -S shutdown -P now"

  http_directory = var.http_directory
  boot_wait = "5s"
  boot_command = [
    "<esc><wait>",
    "install ",
    "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
    "debian-installer=en_US auto locale=en_US ",
    "netcfg/get_hostname=${ var.name } ",
    "netcfg/get_domain=${ var.domain } ",
    "time/zone=${ var.timezone } ",
    "passwd/root-password=${ var.root_password } ",
    "passwd/root-password-again=${ var.root_password } ",
    "passwd/user-fullname=${ var.username } ",
    "passwd/username=${ var.username } ",
    "passwd/user-password=${ var.user_password } ",
    "passwd/user-password-again=${ var.user_password } ",
    "fb=false debconf/frontend=noninteractive ",
    "keyboard-configuration/xkb-keymap=us  ",
    "console-setup/ask_detect=false ",
    "<enter><wait>"
  ]
}

build {
  sources = ["source.virtualbox-iso.debian"]
}