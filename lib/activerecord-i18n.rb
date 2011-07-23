require 'active_record'

module ActiveRecord::I18n

  require 'activerecord-i18n/version'
  require 'activerecord-i18n/column_name'
  require 'activerecord-i18n/attribute_methods'
  require 'activerecord-i18n/serialize'

end

class ActiveRecord::Base
  include ActiveRecord::I18n::AttributeMethods
  include ActiveRecord::I18n::Serialize
end
