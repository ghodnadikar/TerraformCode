
variable "rgname" {
  type = string
}

variable "rglocation" {
  type = string
}


variable "vnetname" {
  type = string
}

variable "addressspace1" {
  type = string 
}

variable "dnsserver1" {
  type = string
}

variable "subnet11" {
 type = string
}

variable "nicname" {
  type = string
}
variable "nsgname" {
  type = string
}

variable "vmname" {
  type = list (any)
}

variable "vmsize" {
  type = string 
}

variable "username" {
  type = string
}



variable "addressprefix11" {
  type = string 
}

# variable "machinecount" {
#   type = number 
# }