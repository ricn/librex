defmodule LibrexTest do
  use ExUnit.Case

  @docx_file Path.join(__DIR__, "fixtures/docx.docx")
  @pptx_file Path.join(__DIR__, "fixtures/pptx.pptx")

  test "convert docx to pdf" do
    pdf_file = random_path <> ".pdf"
    refute File.exists? pdf_file
    Librex.convert(@docx_file, pdf_file)
    assert is_pdf? pdf_file
  end

  test "convert pptx to pdf" do
    pdf_file = random_path <> ".pdf"
    refute File.exists? pdf_file
    Librex.convert(@pptx_file, pdf_file)
    assert is_pdf? pdf_file
  end

  test "convert docx to odt" do
    odt_file = random_path <> ".odt"
    refute File.exists? odt_file
    Librex.convert(@docx_file, odt_file)
    assert is_odt? odt_file
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
    System.tmp_dir! <> SecureRandom.uuid
  end
end
