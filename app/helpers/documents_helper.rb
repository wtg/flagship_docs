module DocumentsHelper

  def document_icon(extension)
    case extension
      when "pdf" then "icon_pdf.png"
      else "icon_other.png"
    end
  end

end
