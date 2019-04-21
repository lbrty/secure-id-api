defmodule Idp.Validators do
  @moduledoc false
  defdelegate validate_password_confirmation(changeset), to: Idp.Validators.Password
  defdelegate check_password(changeset), to: Idp.Validators.Password
end
