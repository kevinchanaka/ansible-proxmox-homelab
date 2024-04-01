# ansible-proxmox-homelab

Playbooks to provision Proxmox environment for my homelab

## Setup

1. Create `.env` file in project root and add the following:

```bash
PROXMOX_USERNAME=YOUR_PROXMOX_USERNAME
PROXMOX_PASSWORD=YOUR_PROXMOX_PASSWORD
```

2. Add Proxmox IP addresses to `hosts.ini` file

```bash
[proxmox]
YOUR_PROXMOX_IP
```

## Usage

### Bootstrap Proxmox nodes

Before creating templates and VMs, proxmox nodes should be bootstrapped by running `make bootstrap`

### Create VM template

To create a cloud-init VM template, a QCow2 image needs to be downloaded to the Proxmox instance. This can be done by running the following:

```bash
# Fetch image from URL and copy to Proxmox machine
make image image_url=<HTTPS_IMAGE_URL>

# Example
make image image_url=https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img

# List available images
make image

# Create VM template using image
make template name=<NAME_OF_TEMPLATE> id=<ID_OF_TEMPLATE> image=<IMAGE_FILE_NAME>

# Example
make template name=ubuntu-jammy id=900 image=jammy-server-cloudimg-amd64.img
```

### Create VMs

Populate VM information in `group_vars/all.yaml` file. All properties are required unless specified otherwise

| Property                | Description                                                                |
| ----------------------- | -------------------------------------------------------------------------- |
| name                    | Name of VM, must be unique                                                 |
| id                      | ID of VM, must be unique                                                   |
| template_id             | ID of template to create VM with                                           |
| cpu                     | Number of CPU cores                                                        |
| memory                  | Amount of memory in MB                                                     |
| disk_size               | Specify size of primary drive to be used by VM                             |
| ip                      | IP address of VM and network prefix                                        |
| gateway                 | Default gateway IP address of VM                                           |
| node (optional)         | Node to create VM on, defaults to first Proxmox node in alphabetical order |
| ssh_key_file (optional) | Public SSH key to allow access to VM, defaults to `~/.ssh/id_rsa.pub`      |

Once information is populated, run `make vms` to create virtual machines
