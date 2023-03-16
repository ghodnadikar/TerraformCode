variable "rglocation" {
  type = string
}

variable "rgname" {
  type = string
}

# variable "mgmtsubnet" {
#   type = string
# }

# variable "appsubnet" {
#   type = string
# }

# variable "dbsubnet" {
#   type = string
# }

variable "vnetname1" {
  type = string
}
variable "addressspace1" {
  type = list (any)
}

variable "vnetlocation" {
  type = string
}

variable "vnetrgname" {
  type = string
}

variable "subnet11" {
  type = string
}

variable "subnet12" {
  type = string
}

variable "subnet13" {
  type = string
}

variable "subnet14" {
  type = string
}

variable "subnet15" {
  type = string
}

variable "addressprefix11" {
  type = list (any)
}

variable "addressprefix12" {
  type = list (any)
}

variable "addressprefix13" {
  type = list (any)
}

variable "addressprefix14" {
  type = list (any)
}

variable "addressprefix15" {
  type = list (any)
}

 variable "vm_size" {
  type = string
 }


 variable "username" {
  type = string

}
 variable "passcode" {
   type = string
 }
variable "caching" {
   type = string

}
variable "storage_account_type" {
   type = string

 }
variable "publisher" {
   type = string

}
 variable "offer" {
   type = string
 }
 variable "sku" {
   type = string

}
variable "version_type" {
   type = string

 }
