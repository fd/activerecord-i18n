describe "ActiveRecord::I18n::ColumnName" do

  describe "#new(:title)" do

    subject { ActiveRecord::I18n::ColumnName.new(:title) }

    describe "with locale :'nl-BE'" do
      before { I18n.locale = :'nl-BE' }

      its(:to_s)   { should ==  "title_f_nl_BE" }
      its(:to_sym) { should == :"title_f_nl_BE" }
    end

    describe "with locale :'en-US'" do
      before { I18n.locale = :'en-US' }

      its(:to_s)   { should ==  "title_f_en_US" }
      its(:to_sym) { should == :"title_f_en_US" }
    end

    describe "with locale :'root'" do
      before { I18n.locale = :'root' }

      its(:to_s)   { should ==  "title_f_root" }
      its(:to_sym) { should == :"title_f_root" }
    end
  end

  describe "#new(:title, :fallback => false)" do

    subject { ActiveRecord::I18n::ColumnName.new(:title, :fallback => false) }

    describe "with locale :'nl-BE'" do
      before { I18n.locale = :'nl-BE' }

      its(:to_s)   { should ==  "title_l_nl_BE" }
      its(:to_sym) { should == :"title_l_nl_BE" }
    end

    describe "with locale :'en-US'" do
      before { I18n.locale = :'en-US' }

      its(:to_s)   { should ==  "title_l_en_US" }
      its(:to_sym) { should == :"title_l_en_US" }
    end

    describe "with locale :'root'" do
      before { I18n.locale = :'root' }

      its(:to_s)   { should ==  "title_l_root" }
      its(:to_sym) { should == :"title_l_root" }
    end
  end

  describe "#new(:title, :locale => :'nl-BE')" do

    subject { ActiveRecord::I18n::ColumnName.new(:title, :locale => :'nl-BE') }

    describe "with locale :'nl-BE'" do
      before { I18n.locale = :'nl-BE' }

      its(:to_s)   { should ==  "title_f_nl_BE" }
      its(:to_sym) { should == :"title_f_nl_BE" }
    end

    describe "with locale :'en-US'" do
      before { I18n.locale = :'en-US' }

      its(:to_s)   { should ==  "title_f_nl_BE" }
      its(:to_sym) { should == :"title_f_nl_BE" }
    end

    describe "with locale :'root'" do
      before { I18n.locale = :'root' }

      its(:to_s)   { should ==  "title_f_nl_BE" }
      its(:to_sym) { should == :"title_f_nl_BE" }
    end
  end

  describe "#new(:title, :locale => :'nl-BE', :fallback => false)" do

    subject { ActiveRecord::I18n::ColumnName.new(:title, :locale => :'nl-BE', :fallback => false) }

    describe "with locale :'nl-BE'" do
      before { I18n.locale = :'nl-BE' }

      its(:to_s)   { should ==  "title_l_nl_BE" }
      its(:to_sym) { should == :"title_l_nl_BE" }
    end

    describe "with locale :'en-US'" do
      before { I18n.locale = :'en-US' }

      its(:to_s)   { should ==  "title_l_nl_BE" }
      its(:to_sym) { should == :"title_l_nl_BE" }
    end

    describe "with locale :'root'" do
      before { I18n.locale = :'root' }

      its(:to_s)   { should ==  "title_l_nl_BE" }
      its(:to_sym) { should == :"title_l_nl_BE" }
    end
  end

end