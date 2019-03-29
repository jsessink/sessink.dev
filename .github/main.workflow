workflow "New workflow" {
  on = "push"
  resolves = ["Deploy to Azure Web App"]
}

action "Azure Login" {
  uses = "Azure/github-actions/login@master"
  env = {
    AZURE_SUBSCRIPTION = "ab3b5eeb-7bcb-4231-b129-97db93cda44f"
  }
  secrets = ["AZURE_SERVICE_APP_ID", "AZURE_SERVICE_PASSWORD", "AZURE_SERVICE_TENANT"]
}

action "Deploy to Azure Web App" {
  uses = "Azure/github-actions/webapp@master"
  needs = ["Azure Login"]
  env = {
    AZURE_APP_NAME = "sessink"
    AZURE_APP_PACKAGE_LOCATION = "./"
  }
}
