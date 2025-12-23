variable "ami_value" {
  description = "AMI ID"
}
variable "instance_type_value" {
  description = "Instance Type"
}
variable "sg_name" {
  description = "Security Group name"
  default     = "allow-ssh-http"
}
variable "sg_description" {
  description = "Security Group description"
  default     = "Allow SSH and HTTP inbound"
}