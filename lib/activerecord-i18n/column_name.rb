class ActiveRecord::I18n::ColumnName

  extend ActiveSupport::Memoizable

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
    locale = locale.to_s.gsub('-', '_').downcase
    :"#{@base}_#{@fallback ? 'f' : 'l'}_#{locale}"
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
