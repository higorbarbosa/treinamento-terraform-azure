remote_state {
    backend = "azurerm"
    config = {
        resource_group_name = "terraformstate"
        storage_account_name = "tfstateaztreinamento"
        container_name = "terraformstate"
        key = "hJmKST3wb+r7Hm1RpS84I/vjUfDba+IBK6WAf+g4ugQwS9s/lNb1qGdhFdAHXm2P/WkW4oZ8LooNFu7AalFjfQ=="
    }
}


inputs = {
    location = "brazilsouth"
    rg = "rg-terragrunt"
}