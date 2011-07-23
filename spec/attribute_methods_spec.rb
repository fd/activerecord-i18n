ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => ":memory:")

ActiveRecord::Base.connection.create_table(:articles) do |t|
  t.string :title_l_root
  t.string :title_f_root
  t.string :title_l_nl_BE
  t.string :title_f_nl_BE
  t.string :title_l_nl_NL
  t.string :title_f_nl_NL

  t.integer :rating_l_root
  t.integer :rating_f_root
  t.integer :rating_l_nl_BE
  t.integer :rating_f_nl_BE
  t.integer :rating_l_nl_NL
  t.integer :rating_f_nl_NL

  t.boolean :published_l_root
  t.boolean :published_f_root
  t.boolean :published_l_nl_BE
  t.boolean :published_f_nl_BE
  t.boolean :published_l_nl_NL
  t.boolean :published_f_nl_NL

  t.text :settings_l_root
  t.text :settings_f_root
  t.text :settings_l_nl_BE
  t.text :settings_f_nl_BE
  t.text :settings_l_nl_NL
  t.text :settings_f_nl_NL
end

class Article < ActiveRecord::Base

  serialize :settings

end

describe "ActiveRecord::I18n::AttributeMethods" do

  subject { Article.new }

  describe "(simple string columns)" do

    it { should respond_to(:title)  }
    it { should respond_to(:title=) }

    it "should store the title for nl-BE" do
      I18n.locale = :'nl-BE'
      subject.title = 'Hello'
      subject.save and subject.reload
      subject.title.should == "Hello"
    end

    it "should store the title for root when it is not already set" do
      I18n.locale = :root
      subject.title.should be_nil
      I18n.locale = :'nl-BE'
      subject.title = 'Hello'
      subject.save and subject.reload
      I18n.locale = :root
      subject.title.should == "Hello"
    end

    it "should fallback to root when no value is set" do
      I18n.locale = :root
      subject.title.should be_nil
      subject.title = 'Hello'
      subject.save and subject.reload
      I18n.locale = :'nl-BE'
      subject.title.should == "Hello"
      I18n.locale = :'nl-NL'
      subject.title.should == "Hello"
    end

    it "should not fallback to root when a value is set" do
      I18n.locale = :root
      subject.title.should be_nil
      subject.title = 'Hello'
      I18n.locale = :'nl-BE'
      subject.title = "Halo"
      subject.save and subject.reload
      subject.title.should == "Halo"
      I18n.locale = :'nl-NL'
      subject.title.should == "Hello"
    end

  end

  describe "(simple integer columns)" do

    it { should respond_to(:rating)  }
    it { should respond_to(:rating=) }

    it "should store the rating for nl-BE" do
      I18n.locale = :'nl-BE'
      subject.rating = 5
      subject.save and subject.reload
      subject.rating.should == 5
    end

    it "should store the rating for root when it is not already set" do
      I18n.locale = :root
      subject.rating.should be_nil
      I18n.locale = :'nl-BE'
      subject.rating = 10
      subject.save and subject.reload
      I18n.locale = :root
      subject.rating.should == 10
    end

    it "should fallback to root when no value is set" do
      I18n.locale = :root
      subject.rating.should be_nil
      subject.rating = 11
      subject.save and subject.reload
      I18n.locale = :'nl-BE'
      subject.rating.should == 11
      I18n.locale = :'nl-NL'
      subject.rating.should == 11
    end

    it "should not fallback to root when a value is set" do
      I18n.locale = :root
      subject.rating.should be_nil
      subject.rating = 15
      I18n.locale = :'nl-BE'
      subject.rating = 17
      subject.save and subject.reload
      subject.rating.should == 17
      I18n.locale = :'nl-NL'
      subject.rating.should == 15
    end

  end

  describe "(simple boolean columns)" do

    it { should respond_to(:published)  }
    it { should respond_to(:published=) }

    it "should store the published for nl-BE (true)" do
      I18n.locale = :'nl-BE'
      subject.published = true
      subject.save and subject.reload
      subject.published.should be_true
    end

    it "should store the published for nl-BE (false)" do
      I18n.locale = :'nl-BE'
      subject.published = false
      subject.save and subject.reload
      subject.published.should be_false
    end

    it "should store the published for root when it is not already set (true)" do
      I18n.locale = :root
      subject.published.should be_nil
      I18n.locale = :'nl-BE'
      subject.published = true
      subject.save and subject.reload
      I18n.locale = :root
      subject.published.should === true
    end

    it "should store the published for root when it is not already set (false)" do
      I18n.locale = :root
      subject.published.should be_nil
      I18n.locale = :'nl-BE'
      subject.published = false
      subject.save and subject.reload
      I18n.locale = :root
      subject.published.should be_false
    end

    it "should fallback to root when no value is set (true)" do
      I18n.locale = :root
      subject.published.should be_nil
      subject.published = true
      subject.save and subject.reload
      I18n.locale = :'nl-BE'
      subject.published.should be_true
      I18n.locale = :'nl-NL'
      subject.published.should be_true
    end

    it "should fallback to root when no value is set (false)" do
      I18n.locale = :root
      subject.published.should be_nil
      subject.published = false
      subject.save and subject.reload
      I18n.locale = :'nl-BE'
      subject.published.should be_false
      I18n.locale = :'nl-NL'
      subject.published.should be_false
    end

    it "should not fallback to root when a value is set (true)" do
      I18n.locale = :root
      subject.published.should be_nil
      subject.published = true
      I18n.locale = :'nl-BE'
      subject.published = false
      subject.save and subject.reload
      subject.published.should be_false
      I18n.locale = :'nl-NL'
      subject.published.should be_true
    end

    it "should not fallback to root when a value is set (false)" do
      I18n.locale = :root
      subject.published.should be_nil
      subject.published = false
      I18n.locale = :'nl-BE'
      subject.published = true
      subject.save and subject.reload
      subject.published.should be_true
      I18n.locale = :'nl-NL'
      subject.published.should be_false
    end

  end

  describe "(serialized columns)" do

    it { should respond_to(:settings)  }
    it { should respond_to(:settings=) }

    it "should store the settings for nl-BE" do
      I18n.locale = :'nl-BE'
      subject.settings = { :awesome_feature => true }
      subject.save and subject.reload
      subject.settings.should == { :awesome_feature => true }
    end

    it "should store the settings for root when it is not already set" do
      I18n.locale = :root
      subject.settings.should be_nil
      I18n.locale = :'nl-BE'
      subject.settings = { :awesome_feature => true }
      subject.save and subject.reload
      I18n.locale = :root
      subject.settings.should == { :awesome_feature => true }
    end

    it "should fallback to root when no value is set" do
      I18n.locale = :root
      subject.settings.should be_nil
      subject.settings = { :awesome_feature => true }
      subject.save and subject.reload
      I18n.locale = :'nl-BE'
      subject.settings.should == { :awesome_feature => true }
      I18n.locale = :'nl-NL'
      subject.settings.should == { :awesome_feature => true }
    end

    it "should not fallback to root when a value is set" do
      I18n.locale = :root
      subject.settings.should be_nil
      subject.settings = { :awesome_feature => true }
      I18n.locale = :'nl-BE'
      subject.settings = { :super_awesome_feature => true }
      subject.save and subject.reload
      subject.settings.should == { :super_awesome_feature => true }
      I18n.locale = :'nl-NL'
      subject.settings.should == { :awesome_feature => true }
    end

  end

end