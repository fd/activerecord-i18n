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
          locale = locale.to_s.gsub('-','_').downcase
          serialize_without_i18n("#{attr_name}_l_#{locale}", class_name)
          serialize_without_i18n("#{attr_name}_f_#{locale}", class_name)
        end
      else
        serialize_without_i18n(attr_name, class_name)
      end
    end

  end

end
