defmodule IdpWeb.Schema.Errors do
  @moduledoc """
  Defines common GraphQL error responses

    * `@project_not_found`,
    * `@membership_exists`,
    * `@already_owner`,
    * `@permission_denied`,
    * `@user_not_active`,
    * `@not_authenticated`
  """
  defmacro __using__(_) do
    quote do
      import IdpWeb.Gettext, only: [gettext: 1]

      @project_not_found {
        :error,
        %{
          message: gettext("Project not found"),
          code: :not_found
        }
      }

      @membership_exists {
        :error,
        %{
          message: gettext("Membership already exists"),
          code: :membership_exists
        }
      }

      @already_owner {
        :error,
        %{
          message: gettext("User is the owner of project"),
          code: :already_owner
        }
      }

      @permission_denied {
        :error,
        %{
          message: gettext("Permission denied"),
          code: :permission_denied
        }
      }

      @user_not_active {
        :error,
        %{
          code: :user_not_active,
          message: gettext("User is not active")
        }
      }

      @not_authenticated {
        :error,
        %{
          code: :not_authenticated,
          message: gettext("Not authenticated")
        }
      }
    end
  end
end
