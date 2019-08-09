# solution-tf-jenkins-deploy
solution for jenkins and node deployment with script using terraform

![Image of problem](https://github.com/bhushangholave/solution-tf-jenkins-deploy/images/solution1.png)

Problem statement 1: Using any IaC (Terraform) create the same infra which is depicted
above. In this you also need to use the userdata to install the Jenkins and
Ansible.

Please change default values as per your project and requirements in 01-create-gcp-compute/variable.tf.json

# If you dont want to do all the variable change just change the projectid variable ee-project-id/ TF_VAR_ee-project-id to your google cloud projectid 

# Follow below instructions with after command git clone git@github.com:bhushangholave/solution-tf-jenkins-deploy.git

```
cd 01-create-gcp-compute

## Set Variables
export TF_VAR_ee-network = "vpc-ee-network"
export TF_VAR_ee-network-description = "created for EE"
export TF_VAR_ee-project-id = "projectid-12345"
export TF_VAR_ee-network-routing-mode = "GLOBAL"
export TF_VAR_ee-subnetwork-public = "ee-public-subnet"
export TF_VAR_ee-subnetwork-public-cidr = "172.20.10.0/24"
export TF_VAR_ee-machinetype-jenkins = "n1-standard-2"
export TF_VAR_ee-node-app-machinename = "ee-node-appnode"
export TF_VAR_ee-machinetype-appnode = "g1-small"
export TF_VAR_ee-region = "asia-south1"
export TF_VAR_ee-zone = "asia-south1-a"
export TF_VAR_ee-machine-image = "ubuntu-1804-lts"
export TF_VAR_ee-machine-appnode-customscript = "sudo /bin/bash -c 'apt-get update -y && sudo apt-get install -qy docker.io'"
export TF_VAR_ee-metadata-tag = "ee-user"
export TF_VAR_ee-tag-http = "http"
export TF_VAR_ee-firewall-tcp-8080 = "ee-firewall-tcp-8080"
export TF_VAR_ee-tag-ssh = "ssh"
export TF_VAR_ee-tag = "ee-script"
export TF_VAR_tag-app-node = "app-node"
export TF_VAR_ee-subnetwork-private-cidr = "172.20.20.0/24"
export TF_VAR_ee-subnetwork-public-cidr = "172.20.10.0/24"
export TF_VAR_ee-subnetwork-private = "ee-subnetwork-private"
export TF_VAR_ee-subnetwork-public = "ee-subnetwork-public"
export TF_VAR_ee-jenkins-port = "8080"
export TF_VAR_ee-firewall-tcp-22 = "ee-firewall-tcp-22"
export TF_VAR_ee-firewall-tcp = "tcp"
export TF_VAR_ee-ssh-port = "22"
export TF_VAR_ee-tag-jenkins = "jenkins"
export TF_VAR_ee-node-jenkins-machinename = "ee-node-jenkins"
export TF_VAR_ee-extip-jenkins = "ee-extip-jenkins"
## Using Plan
terraform plan

## Using Apply
terraform apply

## Using Show
terraform show
```