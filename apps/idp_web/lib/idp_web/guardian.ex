defmodule IdpWeb.Guardian do
  @moduledoc """
  Guardian protocol implementation for `Idp.Users.User`.
  Our single resource and claim here is `Idp.Users.User`.
  Simple stringified `User.id`
  """
  use Guardian, otp_app: :idp_web
  alias Idp.Users

  def subject_for_token(user = %Users.User{}, _claims) do
    {:ok, to_string(user.id)}
  end

  def subject_for_token(_, _), do: {:error, :not_found}

  def resource_from_claims(%{"sub" => user_id}) do
    {:ok, Users.get_user!(user_id)}
  end

  def resource_from_claims(_claims), do: {:error, :no_claims}
end
