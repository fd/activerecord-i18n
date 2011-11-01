require 'activerecord-i18n'

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

ActiveRecord::Base.connection.create_table(:products) do |t|
  t.string :name_l_root
  t.string :name_f_root
  t.string :name_l_nl_BE
  t.string :name_f_nl_BE
  t.string :name_l_nl_NL
  t.string :name_f_nl_NL

  t.integer :price_l_root
  t.integer :price_f_root
  t.integer :price_l_nl_BE
  t.integer :price_f_nl_BE
  t.integer :price_l_nl_NL
  t.integer :price_f_nl_NL
end

RSpec.configure do |config|
end
