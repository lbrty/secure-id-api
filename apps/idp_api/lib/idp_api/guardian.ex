defmodule IdpApi.Guardian do
  @moduledoc """
  Guardian protocol implementation for `Core.User`.
  Our single resource and claim here is `Core.User`.
  Simple stringified `User.id`
  """
  use Guardian, otp_app: :idp_api
  alias Core.{User, Repo}

  def subject_for_token(user = %User{}, _claims) do
    {:ok, to_string(user.id)}
  end

  def subject_for_token(_, _) do
    {:error, :no_user}
  end

  def resource_from_claims(%{"sub" => user_id}) do
    user = User |> Repo.get(user_id)
    {:ok, user}
  end

  def resource_from_claims(_claims) do
    {:error, :no_claims}
  end
end
