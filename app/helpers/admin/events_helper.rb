module Admin::EventsHelper
  def link_to_add_fields(body, association, f, container, source, selection, html_options={})
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end

    html_options[:class] = "" if html_options[:class].nil?
    html_options[:class] = html_options[:class] + " add-fields"

    html_options[:data] = {} if html_options[:data].nil?
    html_options[:data].merge!({id: id, fields: fields.gsub("\n", ""), container: container, source: source, selection: selection})

    link_to body, '#', html_options
  end
end
