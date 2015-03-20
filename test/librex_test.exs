defmodule LibrexTest do
  use ExUnit.Case

  @docx_file Path.join(__DIR__, "fixtures/docx.docx")
  @odt_file Path.join(__DIR__, "fixtures/odt.odt")

  @pptx_file Path.join(__DIR__, "fixtures/pptx.pptx")
  @odp_file Path.join(__DIR__, "fixtures/odp.odp")

  @xlsx_file Path.join(__DIR__, "fixtures/xlsx.xlsx")
  @ods_file Path.join(__DIR__, "fixtures/ods.ods")

  @non_existent_file Path.join(__DIR__, "fixtures/non.existent")

  test ".convert docx to other supported formats" do
    Enum.each(Librex.supported_document_formats, fn(format) -> test_conversion(@docx_file, format) end)
  end

  test ".convert odt to other supported formats" do
    Enum.each(Librex.supported_document_formats, fn(format) -> test_conversion(@odt_file, format) end)
  end

  test ".convert pptx to other supported formats" do
    Enum.each(Librex.supported_presentation_formats, fn(format) -> test_conversion(@pptx_file, format) end)
  end

  test ".convert odp to other supported formats" do
    Enum.each(Librex.supported_presentation_formats, fn(format) -> test_conversion(@odp_file, format) end)
  end

  test ".convert xlsx to other supported formats" do
    Enum.each(Librex.supported_spreadsheet_formats, fn(format) -> test_conversion(@xlsx_file, format) end)
  end

  test ".convert ods to other supported formats" do
    Enum.each(Librex.supported_spreadsheet_formats, fn(format) -> test_conversion(@ods_file, format) end)
  end

  defp test_conversion(input_file, output_format) do
    output_file = random_path <> "." <> output_format
    refute File.exists? output_file
    { :ok, result } = Librex.convert(input_file, output_file)
    assert output_file == result
  end

  test ".convert must return error when file to convert does not exist" do
    { :error, reason } = Librex.convert(@non_existent_file, "/tmp/output.pdf")
    assert reason == :enoent
  end

  test ".convert! must return output file path" do
    pdf_file = random_path <> ".pdf"
    out_file = Librex.convert!(@docx_file, pdf_file)
    assert pdf_file == out_file
  end

  test ".convert! must raise error when file to convert does not exist" do
    msg = "could not read #{@non_existent_file}: no such file or directory"
    assert_raise File.Error, msg, fn ->
      Librex.convert!(@non_existent_file, "/tmp/output.pdf")
    end
  end

  test "convert must return error when LibreOffice executable can't be found" do
    cmd = "sofice" # misspelled
    msg = "LibreOffice (#{cmd}) executable could not be found."
    {:error, reason} = Librex.convert(@docx_file, "/tmp/output.pdf", "sofice")
    assert reason == msg
  end

  test "convert! must raise error when LibreOffice executable can't be found" do
    cmd = "sofice" # misspelled
    msg = "LibreOffice (#{cmd}) executable could not be found."

    assert_raise RuntimeError, msg, fn ->
      Librex.convert!(@docx_file, "/tmp/output.pdf", "sofice")
    end
  end

  test "convert must have the possibility to specify LibreOffice command" do
    pdf_file = random_path <> ".pdf"
    { :ok, out_file } = Librex.convert(@docx_file, pdf_file, System.find_executable("soffice"))
    assert pdf_file == out_file
    assert is_pdf? pdf_file
  end

  test "convert must return error when file to convert is directory" do
    pdf_file = random_path <> ".pdf"
    assert Librex.convert(System.tmp_dir!, pdf_file) == {:error, :eisdir}
  end

  test ".convert! must raise error when file to convert is directory" do
    msg = "could not read #{System.tmp_dir!}: illegal operation on a directory"
    assert_raise File.Error, msg, fn ->
      Librex.convert!(System.tmp_dir!, "/tmp/output.pdf")
    end
  end

  test "convert must return error when output file has wrong extension" do
    { :error, reason } = Librex.convert(@docx_file, "/tmp/output.mp3")
    assert reason == "mp3 is not a supported output format"
  end

  test "convert! must raise error when output file has wrong extension" do
    msg = "mp3 is not a supported output format"
    assert_raise RuntimeError, msg, fn ->
      Librex.convert!(@docx_file, "/tmp/output.mp3")
    end
  end

  defp is_pdf?(file) do
    { :ok, data } = File.read(file)
    String.starts_with? data, "%PDF"
  end

  defp random_path do
    System.tmp_dir! <> "/" <> SecureRandom.uuid
  end
end
