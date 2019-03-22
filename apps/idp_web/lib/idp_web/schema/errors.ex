defmodule IdpWeb.Schema.Errors do
  @moduledoc """
  Defines common GraphQL error responses

    * `@project_not_found`,
    * `@membership_exists`,
    * `@already_owner`,
    * `@permission_denied`
  """
  defmacro __using__(_) do
    quote do
      @project_not_found {
        :error,
        message: "Project not found",
        code: :not_found
      }

      @membership_exists {
        :error,
        message: "Membership already exists",
        code: :membership_exists
      }

      @already_owner {
        :error,
        message: "User is the owner of project",
        code: :already_owner
      }

      @permission_denied {
        :error,
        message: "Permission denied",
        code: :permission_denied
      }
    end
  end
end
