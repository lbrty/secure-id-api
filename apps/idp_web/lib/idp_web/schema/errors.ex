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

      @permission_exists {
        :error,
        %{
          message: gettext("Permission already exists"),
          code: :permission_exists
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

      @invalid_credentials {
        :error,
        %{
          code: :invalid_credentials,
          message: gettext("Invalid credentials")
        }
      }

      @user_not_found {
        :error,
        %{
          code: :user_not_found,
          message: gettext("User not found")
        }
      }

      @not_found {
        :error,
        %{
          code: :not_found,
          message: gettext("Not found")
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
