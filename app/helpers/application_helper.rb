module ApplicationHelper
  def item_type_select
    
    options_html = content_tag :option, value: "0" do
      "All"
    end

    @item_types.each do |t|
      options_html += content_tag :option, value: t.id do
        t.name
      end
    end

    content_tag :select, name: "type" do
      options_html.html_safe
    end
  end
end
