variable "regras_entrada" {
  type = map
  default = {
      101 = 80
      102 = 443
      103 = 3389
      104 = 22
  }
}
