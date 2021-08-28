# Add .tfenv and .tgenv to PATH
export PATH="${PATH}:${HOME}/.tfenv/bin:${HOME}/.tgenv/bin"

# Terraform aliases
alias tfi='terraform init'
alias tfv='terraform validate'
alias tfp='terraform plan'
alias tfa='terraform apply'

# Terragrunt aliases
alias tgi='terragrunt init --terragrunt-source-update'
alias tgp='terragrunt plan'
alias tga='terragrunt apply'
