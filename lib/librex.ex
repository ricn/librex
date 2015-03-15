defmodule Librex do

  def convert(file_to_convert, out_file) do
    file_name_only = Path.basename(file_to_convert, Path.extname(file_to_convert))
    convert_to = String.replace(Path.extname(out_file), ".", "")
    out_dir = System.tmp_dir! <> SecureRandom.uuid <> "/"
    run(file_to_convert, out_dir, convert_to)
    temp_file = out_dir <> file_name_only <> Path.extname(out_file)
    File.cp! temp_file, out_file
    File.rm! temp_file
    File.rmdir! out_dir
  end

  defp run(file_to_convert, out_dir, convert_to) do
    opts = ["--headless", "--convert-to", convert_to, "--outdir", out_dir, file_to_convert]
    System.cmd("soffice", opts, stderr_to_stdout: true)
  end
end
