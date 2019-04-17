defmodule Idp.EctoHelpers do
  alias Ecto.Changeset

  @doc """
  Transform `Changeset` errors to a list of
  maps containing field name on which validation
  error happened and it's formatted message

  For example:

  ```
  [
    %{
      "title": "title length should be at least 8 characters"
    }
    ...
  ]
  ```
  """
  def to_api_errors(changeset = %Changeset{}) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end

  @doc """
  Wrap context actions with Ecto.
  If action succeeds then the result tuple returned.
  If changeset errors happen then all errors transformed
  into convenient form of list of maps with fields on
  which validations failed.
  Else `unknown` error returned.
  """
  def action_wrapped(fun) do
    case fun.() do
      {:ok, result} -> {:ok, result}

      {:error, error = %Ecto.Changeset{}} ->
        {
          :error,
          %{
            message: "Changeset errors occurred",
            code: :schema_errors,
            errors: to_api_errors(error)
          }
        }

      {:error, _} ->
        {
          :error,
          %{
            message: "Oops! Unknown error",
            code: :oops
          }
        }
    end
  end
end
