defmodule LibrexTest do
  use ExUnit.Case

  @docx_file Path.join(__DIR__, "fixtures/docx.docx")
  @pptx_file Path.join(__DIR__, "fixtures/pptx.pptx")
  @non_existent_file Path.join(__DIR__, "fixtures/non.existent")

  test ".convert docx to pdf" do
    pdf_file = random_path <> ".pdf"
    refute File.exists? pdf_file
    { :ok, out_file } = Librex.convert(@docx_file, pdf_file)
    assert pdf_file == out_file
    assert is_pdf? pdf_file
  end

  test ".convert pptx to pdf" do
    pdf_file = random_path <> ".pdf"
    refute File.exists? pdf_file
    { :ok, out_file } = Librex.convert(@pptx_file, pdf_file)
    assert pdf_file == out_file
    assert is_pdf? pdf_file
  end

  test ".convert docx to odt" do
    odt_file = random_path <> ".odt"
    refute File.exists? odt_file
    { :ok, out_file } = Librex.convert(@docx_file, odt_file)
    assert odt_file == out_file
    assert is_odt? odt_file
  end

  test ".convert must return :error when file to convert does not exist" do
    { :error, reason } = Librex.convert(@non_existent_file, "/tmp/output.pdf")
    assert reason == :enoent
  end

  test ".convert! must return output file path" do
    pdf_file = random_path <> ".pdf"
    out_file = Librex.convert!(@docx_file, pdf_file)
    assert pdf_file == out_file
  end

  test ".convert! raise error when file to convert does not exist" do
    msg = "could not read #{@non_existent_file}: no such file or directory"
    assert_raise File.Error, msg, fn ->
      Librex.convert!(@non_existent_file, "/tmp/output.pdf")
    end
  end

  defp is_pdf?(file) do
    { :ok, data } = File.read(file)
    String.starts_with? data, "%PDF"
  end

  defp is_odt?(file) do
    { :ok, data } = File.read(file)
    String.contains? data, "application/vnd.oasis.opendocument.text"
  end

  defp random_path do
    System.tmp_dir! <> "/" <> SecureRandom.uuid
  end
end
