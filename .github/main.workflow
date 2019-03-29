workflow "New workflow" {
  on = "push"
  resolves = ["Deploy to Azure Web App"]
}

action "Deploy to Azure" {
  uses = "./.github/actions/azure-deploy"
  secrets = ["SERVICE_PASS"]
  env = {
    SERVICE_PRINCIPAL="sessink",
    TENANT_ID="3aef123d-bef5-4103-b48b-87c38cf24cd0",
    APPID="3aef123d-bef5-4103-b48b-87c38cf24cd0"
  }
}

action "Deploy to Azure Web App" {
  uses = "Azure/github-actions/webapp@master"
  needs = ["Azure Login"]
  env = {
    AZURE_APP_NAME = "sessink"
    AZURE_APP_PACKAGE_LOCATION = "./"
  }
}
