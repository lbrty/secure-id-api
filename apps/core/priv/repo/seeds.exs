alias Core.Repo
alias Core.Project

Repo.insert! %Project{
  project_name: "Test project",
  description: "Project description"
}
