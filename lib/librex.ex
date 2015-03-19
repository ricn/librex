defmodule Librex do
  @moduledoc """
  Provides functions to convert office documents to other formats.

   ## Examples
      iex(1)> Librex.convert("test/fixtures/docx.docx", "/Users/ricn/docx.pdf")
      {:ok, "/Users/ricn/docx.pdf"}

      iex(2)> Librex.convert("non_existent_file", "/Users/ricn/docx.pdf")
      {:error, :enoent}

      iex(3)> Librex.convert!("test/fixtures/docx.docx", "/Users/ricn/docx.pdf")
      "/Users/ricn/docx.pdf"

      iex(4)> Librex.convert!("non_existent_file", "/Users/ricn/docx.pdf")
      ** (File.Error) could not read non_existent_file: no such file or directory
      (librex) lib/librex.ex:13: Librex.convert!/3
   """

  @doc """
    Converts in_file to out_file
    Returns `:ok` if successful, `{:error, reason}` otherwise.
  """
  def convert(in_file, out_file, soffice_cmd \\ "soffice") do
    case validate(in_file, out_file, soffice_cmd) do
      {:ok, _}  -> do_convert(in_file, out_file, soffice_cmd)
      {:error, reason } -> {:error, reason}
    end
  end

  @doc """
    The same as `convert/3`, but raises an exception if it fails.
  """
  def convert!(in_file, out_file, soffice_cmd \\ "soffice") do
    case convert(in_file, out_file, soffice_cmd) do
      {:ok, _}      -> out_file
      {:error, reason} -> raise_error(reason, in_file)
    end
  end

  defp raise_error(reason, in_file) do
    if is_atom(reason) do
      raise File.Error, reason: reason, action: "read", path: in_file
    else
      raise RuntimeError, message: reason
    end
  end

  defp validate(input_file, output_file, soffice_cmd) do
    validate_input(input_file)
    |> validate_output(output_file)
    |> validate_soffice(soffice_cmd)
  end

  defp validate_input(input_file) do
    File.read(input_file)
  end

  defp validate_output(result, output_file) do
    output_ext = String.replace(Path.extname(output_file), ".", "")
    if Enum.any?(supported_formats, fn(ext) -> ext == output_ext end) do
      result
    else
      {:error, "#{output_ext} is not a supported output format"}
    end
  end

  defp supported_formats do
    supported_doc_formats ++ supported_presentation_formats ++ supported_spreadsheet_formats
  end

  def supported_doc_formats do
    ["pdf", "odt", "txt", "rtf", "docx", "doc"]
  end

  def supported_presentation_formats do
    ["pdf", "odp", "txt", "pptx", "ppt"]
  end

  def supported_spreadsheet_formats do
    ["pdf", "ods", "xlsx", "csv", "xls"]
  end

  defp validate_soffice(result, soffice_cmd) do
    if System.find_executable(soffice_cmd) do
      result
    else
      {:error, "LibreOffice (#{soffice_cmd}) executable could not be found."}
    end
  end

  defp do_convert(in_file, out_file, soffice_cmd) do
    basename = Path.basename(in_file, Path.extname(in_file))
    convert_to = String.replace(Path.extname(out_file), ".", "")
    out_temp_dir = System.tmp_dir! <> "/" <> SecureRandom.uuid <> "/"
    out_temp_file = out_temp_dir <> basename <> Path.extname(out_file)

    run(in_file, out_temp_dir, convert_to, soffice_cmd)

    File.cp! out_temp_file, out_file
    File.rm! out_temp_file
    File.rmdir! out_temp_dir

    {:ok, out_file}
  end

  defp run(file_to_convert, out_dir, convert_to, soffice_cmd) do
    opts = ["--headless", "--convert-to", convert_to, "--outdir", out_dir, file_to_convert]
    cmd = System.find_executable(soffice_cmd)
    System.cmd(cmd, opts, stderr_to_stdout: true)
  end
end
