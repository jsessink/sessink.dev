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

action "Is Master Push Check" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Is Not PR Merge Check" {
  uses = "actions/bin/filter@master"
  args = "merged false"
}

action "Azure Login For PR" {
  uses = "Azure/github-actions/login@master"
  needs = ["Is Not PR Merge Check"]
  env = {
    AZURE_SUBSCRIPTION = "Visual Studio Enterprise"
  }
  secrets = ["AZURE_SERVICE_APP_ID", "AZURE_SERVICE_PASSWORD", "AZURE_SERVICE_TENANT"]
}

action "Azure Login After Master Push" {
  uses = "Azure/github-actions/login@master"
  needs = ["Is Master Push Check"]
  env = {
    AZURE_SUBSCRIPTION = "Visual Studio Enterprise"
  }
  secrets = ["AZURE_SERVICE_APP_ID", "AZURE_SERVICE_PASSWORD", "AZURE_SERVICE_TENANT"]
}

action "Deploy to Azure Web App" {
  uses = "Azure/github-actions/webapp@master"
  needs = ["Azure Login After Master Push"]
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
