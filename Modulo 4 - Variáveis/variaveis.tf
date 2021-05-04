variable "namerg" {
  type = string
  description = "Nome do Resource Group"
  default = "rg-variaveis"
}


variable "location" {
  type = string
  description = "Localizacao dos Rercursos do Azure. Ex: brazilsouth"
  //default = "eastus"

}


variable "tags" {
  type = map
  description = "Tags nos Recursos e Servicos do azure"
  default = {
      ambiente = "desenvolvimento"
      responsavel = "Higor Luis Barbosa"
  }
}

variable "vnetenderecos" {
  type = list
  default = ["10.0.0.0/16", "192.168.0.0/16"]
}


