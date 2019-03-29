workflow "New workflow" {
  on = "push"
  resolves = ["azure"]
}

action "azure" {
  uses = "docker://alpine/git:latest"
  runs = "entrypoint.sh"
}
