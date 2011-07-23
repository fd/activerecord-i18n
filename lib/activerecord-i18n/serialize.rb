module ActiveRecord::I18n::Serialize

  def self.included(base)
    base.extend ClassMethods
    class << base
      alias_method_chain :serialize, :i18n
    end
  end

  module ClassMethods

    def serialize_with_i18n(attr_name, class_name = Object)
      attr_name = attr_name.to_s

      locales = localized_columns[attr_name]

      if locales
        locales.each do |locale|
          l = ActiveRecord::I18n::Inference.format_i18n_column_name(
                attr_name, locale, false)
          f = ActiveRecord::I18n::Inference.format_i18n_column_name(
                attr_name, locale, true)

          serialize_without_i18n(l, class_name)
          serialize_without_i18n(f, class_name)
        end
      else
        serialize_without_i18n(attr_name, class_name)
      end
    end

  end

end
