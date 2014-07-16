module DocumentsHelper

  def document_icon(extension)
    case extension
      when "pdf" then "icon_pdf.png"
      when "odt" then "icon_odt.png"
      when "doc" then "icon_doc.png"
      else "icon_other.png"
    end
  end

  def small_document_icon(extension)
    case extension
      when "pdf" then "icon_pdf_40.png"
      when "odt" then "icon_odt_40.png"
      when "doc" then "icon_doc_40.png"
      else "icon_other_40.png"
    end
  end

end
