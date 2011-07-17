module ApplicationHelper
  def hidden_div_if(condition, attributes = {}, &block)
    if condition 
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)  # wraps the output created by the block in div tags
    #&block is the chunk of code (block) passed to the method as a parameter
  end
end
