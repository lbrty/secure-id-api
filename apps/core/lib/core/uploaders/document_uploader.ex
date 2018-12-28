defmodule Core.DocumentUploader do
  use Arc.Definition
  use Arc.Ecto.Definition

  @versions [:original]
  @whitelist ~w(.jpg .jpeg .gif .png .rtf .doc .docx .odt .xls .xlsx .pdf .txt)

  def __storage, do: Arc.Storage.Local

  # Whitelist file extensions:
  def validate({file, _}) do
    ext =
      file.file_name
      |> String.downcase()
      |> Path.extname()

    @whitelist |> Enum.member?(ext)
  end
end
