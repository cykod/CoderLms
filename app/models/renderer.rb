class Renderer 


  def self.render(extension,src)
  if extension == "md"
      self.markdown(src.to_s)
    else
      src.to_s
    end

  end

  def self.markdown(txt)
    Kramdown::Document.new(txt,
                          { syntax_highlighter_opts: { line_numbers: false }}).to_html
  end
end
