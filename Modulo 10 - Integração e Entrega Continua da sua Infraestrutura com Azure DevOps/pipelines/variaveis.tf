variable "location" {
  type = string
  default = "brazilsouth"
}

variable "tags" {
  type = map
  default = {
      "ambiente" = "teste"
      "integracaocontinua" = "ativada"
      "entregacontinua" = "ativada"
    }
}
