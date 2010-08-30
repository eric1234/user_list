lib 'test_gem_locator.rb', <<FILE
class TestGemLocator < Rails::Plugin::Locator
  def plugins
    Rails::Plugin.new(File.join(File.dirname(__FILE__), *%w(.. .. ..)))
  end
end
FILE

lib 'tasks/user_list_tasks.rake', <<FILE
require File.join(File.dirname(__FILE__), *%w(.. .. .. .. lib user_list rails_tasks))
FILE

environment <<CONFIG
require 'test_gem_locator'
config.plugin_locators << TestGemLocator
CONFIG

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

rake 'user_list:assets:copy'
