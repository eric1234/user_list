environment <<CONFIG
  require File.join(File.dirname(__FILE__), *%w(.. .. .. lib user_list.rb))
CONFIG

gem 'ruby-debug'

# Everything below is suggested setup for an app using the gem

gem 'authlogic'

file "db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S")}_add_user.rb", <<MIGRATION
class AddUser < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name, :email, :null => false
      t.string :crypted_password, :password_salt, :persistence_token
      t.boolean :active, :default => true, :null => false
    end
  end

  def self.down
    drop_table :users
  end
end
MIGRATION

file 'app/models/user.rb', <<USER
class User < ActiveRecord::Base
  acts_as_authentic
end
USER

file 'app/views/layouts/application.html.erb', <<LAYOUT
<!DOCTYPE html>
<html lang="en-US">
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
    <%= stylesheet_link_tag 'user_list', :media => :all %>
  </head>

  <body>
    <%= yield %>
    <%= javascript_include_tag 'http://ajax.googleapis.com/ajax/libs/prototype/1.6.1.0/prototype.js', 'user_list' %>
  </body>
</html>
LAYOUT
