module DocumentsHelper

  def document_icon(extension)
    case extension
      when "pdf" then "icon_pdf.png"
      when "odt" then "icon_odt.png"
      when "doc" then "icon_doc.png"
      else "icon_other.png"
    end
  end

end
