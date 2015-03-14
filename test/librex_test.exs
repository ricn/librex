defmodule LibrexTest do
  use ExUnit.Case

  @docx_file Path.join(__DIR__, "fixtures/docx.docx")
  @pptx_file Path.join(__DIR__, "fixtures/pptx.pptx")

  test "convert docx to pdf" do
    pdf_file = System.tmp_dir! <> SecureRandom.uuid <> ".pdf"
    assert !File.exists? pdf_file
    Librex.convert(@docx_file, pdf_file)
    assert File.exists?(pdf_file)
  end

  test "convert pptx to pdf" do
    pdf_file = System.tmp_dir! <> SecureRandom.uuid <> ".pdf"
    assert !File.exists? pdf_file
    Librex.convert(@pptx_file, pdf_file)
    assert File.exists?(pdf_file)
  end
end
