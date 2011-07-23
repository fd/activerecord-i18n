require 'active_record'

module ActiveRecord::I18n

  require 'activerecord-i18n/version'
  require 'activerecord-i18n/column_name'
  require 'activerecord-i18n/attribute_methods'
  require 'activerecord-i18n/serialize'

end

# ActiveSupport.on_load(:active_record) do
  ActiveRecord::Base.send :include, ActiveRecord::I18n::AttributeMethods
  ActiveRecord::Base.send :include, ActiveRecord::I18n::Serialize
# end
