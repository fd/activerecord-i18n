module ActiveRecord::I18n::Inference

  RECOGNIZE_I18N_COLUMN = /^(.+)_l_(?:([a-z]{2,})(?:_([A-Z]{2,}))?)$/

  def format_i18n_column_name(base, locale, fallback)
    fallback = (fallback ? 'f' : 'l')
    locale   = locale.to_s.gsub('-', '_')
    :"#{base}_#{fallback}_#{locale}"
  end

  def parse_i18n_column_name(column_name)
    if column_name.to_s =~ RECOGNIZE_I18N_COLUMN
      locale = [$2, $3].compact.join('-').to_sym
      [$1, locale]
    end
  end

  extend self

end

class ActiveRecord::I18n::ColumnName

  extend ActiveSupport::Memoizable
  include ActiveRecord::I18n::Inference

  DEFAULTS = { :fallback => true, :locale => nil }

  def initialize(base, options={})
    options = DEFAULTS.merge(options || {})

    @base     = base.to_s
    @fallback = !!options[:fallback]
    @locale   = options[:locale]
  end

  def inspect
    to_sym.inspect
  end

  def to_s
    to_sym.to_s
  end

  def to_sym
    for_locale(@locale || ::I18n.locale)
  end

  def for_locale(locale)
    self.format_i18n_column_name(@base, locale, @fallback)
  end
  memoize :for_locale

end

class Symbol

  def localize(locale=nil, options={})
    if Hash === locale
      options = locale
      locale  = nil
    else
      options[:locale] = locale
    end

    ActiveRecord::I18n::ColumnName.new(self, options)
  end
  alias l localize

end
