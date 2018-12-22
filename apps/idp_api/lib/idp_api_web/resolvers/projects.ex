defmodule IdpApiWeb.Resolvers.Projects do
  def all(_parent, _args, _resolution) do
    {:ok, Core.Project |> Core.Repo.all}
  end
end
