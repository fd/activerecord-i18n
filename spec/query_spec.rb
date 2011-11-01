require File.expand_path('../spec_helper', __FILE__)

I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)

class Product < ActiveRecord::Base

  if respond_to?(:where)
    scope :free, lambda{ where(:price.l => 0) }
  else
    named_scope :free, :conditions => { :price.l => 0 }
  end

end

describe "Queries" do

  before  { I18n.fallbacks.defaults = [:'nl-BE', :root] }
  before  { Product.reset_column_information }

  describe "(named_)scope :free" do

    before do
      I18n.locale = :'nl-BE'
      Product.create(:name => 'Air',     :price => 0)
      Product.create(:name => 'Sun',     :price => 0)
      Product.create(:name => 'Diamond', :price => 100_000)
    end

    it do
      I18n.locale = :'nl-BE'
      products = Product.free.all
      products.size.should == 2
      products.map(&:name).should == %w( Air Sun )

      I18n.locale = :'nl-NL'
      products = Product.free.all
      products.size.should == 2
      products.map(&:name).should == %w( Air Sun )
    end

  end

end