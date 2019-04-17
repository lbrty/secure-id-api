defmodule IdpWeb.Schema.Errors do
  @moduledoc """
  Defines common GraphQL error responses

    * `@project_not_found`,
    * `@membership_exists`,
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

      @user_already_exists {
        :error,
        %{
          code: :user_already_exists,
          message: gettext("User already exists")
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
