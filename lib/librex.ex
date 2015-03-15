defmodule Librex do

  def convert(in_file, out_file) do
    basename = Path.basename(in_file, Path.extname(in_file))
    convert_to = String.replace(Path.extname(out_file), ".", "")
    out_temp_dir = System.tmp_dir! <> SecureRandom.uuid <> "/"
    out_temp_file = out_temp_dir <> basename <> Path.extname(out_file)

    run(in_file, out_temp_dir, convert_to)

    File.cp! out_temp_file, out_file
    File.rm! out_temp_file
    File.rmdir! out_temp_dir
  end

  defp run(file_to_convert, out_dir, convert_to) do
    opts = ["--headless", "--convert-to", convert_to, "--outdir", out_dir, file_to_convert]
    System.cmd("soffice", opts, stderr_to_stdout: true)
  end
end
