
class HTMLwithPygments < Redcarpet::Render::HTML
  def block_code(code, lang)
  	if (lang == nil)
  		lang = "text"
  	end	
    output = add_code_tags(
      Pygmentize.process(code, lang), lang
    )
  end

  def add_code_tags(code, lang)
    code = code.sub(/<\/pre>/,"</code></pre>")
  end
end

module ApplicationHelper

	def markdown(text)
	    options = {
	      filter_html:     true,
	      hard_wrap:       true,
	      link_attributes: { rel: 'nofollow', target: "_blank" },
	      space_after_headers: true,
	      fenced_code_blocks: true
	    }

	    extensions = {
	      autolink:           true,
	      superscript:        true,
	      disable_indented_code_blocks: true,
	      fenced_code_blocks: true,
	      tables: true
	    }

	    renderer = HTMLwithPygments.new(options)

	    markdown = Redcarpet::Markdown.new(renderer, extensions)

	    markdown.render(text).html_safe
	end
end
