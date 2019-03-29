workflow "On PR Push to Staging" {
  on = "pull_request"
  resolves = ["Deploy to Azure Web App Staging"]
}

workflow "On Push Deploy to Prod" {
  resolves = [
    "Deploy to Azure Web App"
  ]
  on = "push"
}

action "Azure Login" {
  uses = "Azure/github-actions/login@master"
  needs = ["Master Push"],
  env = {
    AZURE_SUBSCRIPTION = "Visual Studio Enterprise"
  }
  secrets = ["AZURE_SERVICE_APP_ID", "AZURE_SERVICE_PASSWORD", "AZURE_SERVICE_TENANT"]
}

action "Master Push" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Deploy to Azure Web App" {
  uses = "Azure/github-actions/webapp@master"
  needs = ["Azure Login"]
  env = {
    AZURE_APP_NAME = "Sessink"
    AZURE_APP_PACKAGE_LOCATION = "./"
  }
}

action "Deploy to Azure Web App Staging" {
  uses = "Azure/github-actions/webapp@master"
  needs = ["Azure Login"]
  env = {
    AZURE_APP_NAME = "SessinkStaging"
    AZURE_APP_PACKAGE_LOCATION = "./"
  }
}
