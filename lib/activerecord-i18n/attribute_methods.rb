module ActiveRecord::I18n::AttributeMethods

  extend ActiveSupport::Memoizable

  def self.included(base)
    base.extend ClassMethods
    class << base
      alias_method_chain :reset_column_information, :i18n
    end
  end

  module ClassMethods

    def reset_column_information_with_i18n
      reset_column_information_without_i18n
      @localized_columns = @localized_proxy_class = nil
    end

    def localized_columns
      @localized_columns ||= begin
        columns = {}

        column_names.each do |name|
          base, locale = ActiveRecord::I18n::Inference.parse_i18n_column_name(name)

          next unless base and locale

          (columns[base] ||= []).push(locale)
        end

        columns
      end
    end

    def localized_proxy_class
      @localized_proxy_class ||= begin
        klass = Class.new(ActiveRecord::I18n::AttributeMethods::Proxy)

        localized_columns.each do |column, locales|

          l_reader  = []
          f_reader  = []
          writer    = []
          fallbacks = []

          if I18n.respond_to?(:fallbacks)
            # tsort the locales
          else
            locales.delete(:root)
            locales = [:root] + locales
            locales = locales.map do |l|
              [l, (l == :root ? nil : :root)]
            end
          end

          locales.each do |(l, fallback)|
            c = l.to_s.gsub('-', '_')

            l_reader << "when #{l.inspect} then @object.#{column}_l_#{c}"

            f_reader << "when #{l.inspect} then @object.#{column}_f_#{c}"

            writer.push <<-STR
              when #{l.inspect}
                @object.#{column}_l_#{c} = value
                if @object.#{column}_l_root.nil?
                  @object.#{column}_l_root = value
                end
            STR

            if fallback
              f = fallback.to_s.gsub('-', '_')
              fallbacks.push <<-STR
                unless @object.#{column}_l_#{c}.nil?
                  @object.#{column}_f_#{c} = @object.#{column}_l_#{c}
                else
                  @object.#{column}_f_#{c} = @object.#{column}_f_#{f}
                end
              STR
            else
              fallbacks.push <<-STR
                @object.#{column}_f_#{c} = @object.#{column}_l_#{c}
              STR
            end
          end

          klass.module_eval <<-STR, __FILE__, __LINE__
            def _#{column}
              if @fallback
                case (@locale || I18n.locale)
                #{f_reader.join("\n")}
                else raise "Uknown locale \#{I18n.locale} for #{self}##{column}"
                end
              else
                case (@locale || I18n.locale)
                #{l_reader.join("\n")}
                else raise "Uknown locale \#{I18n.locale} for #{self}##{column}"
                end
              end
            end

            def _#{column}=(value)
              case (@locale || I18n.locale)
              #{writer.join("\n")}
              else raise "Uknown locale \#{I18n.locale} for #{self}##{column}"
              end
              #{fallbacks.join("\n")}
              value
            end

            alias_method :#{column},  :_#{column}
            alias_method :#{column}=, :_#{column}=
          STR

        end

        klass
      end
    end

    def define_attribute_methods
      super

      if respond_to?(:generated_methods)
        mod = self
        set = generated_methods
      else
        mod = generated_attribute_methods
        set = Set.new
      end

      localized_columns.each do |column, locales|
        set << :"_#{column}"
        set << :"_#{column}="
        set << :"#{column}"
        set << :"#{column}="

        mod.module_eval <<-STR, __FILE__, __LINE__
          def _#{column}
            localize.#{column}
          end

          def _#{column}=(value)
            localize.#{column} = value
          end

          alias_method :#{column},  :_#{column}
          alias_method :#{column}=, :_#{column}=
        STR

      end
    end

  end

  def localize(locale=nil, options={})
    if Hash === locale
      options = locale
      locale  = nil
    else
      options[:locale] = locale
    end

    self.class.localized_proxy_class.new(self, options)
  end
  memoize :localize
  alias l localize

  class Proxy

    DEFAULTS = { :fallback => true, :locale => nil }

    def initialize(object, options={})
      options = DEFAULTS.merge(options || {})

      @object   = object
      @fallback = !!options[:fallback]
      @locale   = options[:locale]
    end

  end

end
