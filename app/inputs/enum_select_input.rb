class EnumSelectInput < SimpleForm::Inputs::CollectionSelectInput
  def input
    label_method, value_method = detect_collection_methods

    @builder.enum_select(
        attribute_name,
        input_options, input_html_options
    )
  end
end