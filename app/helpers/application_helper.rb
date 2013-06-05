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

    content_tag :select, name: "type", style: "width: 150px" do
      options_html.html_safe
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, sort: column, direction: direction
  end
end
