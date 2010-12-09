require 'rake/testtask'
require 'rake/gempackagetask'

desc 'Prepare testing by creating test app'
task :test_app do
  sh "rails new test/test_app -q -m test/test_app_template.rb " unless
    File.exists? 'test/test_app'
end

spec = eval File.read('user_list.gemspec')
Rake::GemPackageTask.new spec do |pkg|
  pkg.need_tar = false
end

desc "Publish gem to rubygems.org"
task :publish => :package do
  `gem push pkg/#{spec.name}-#{spec.version}.gem`
end

Rake::TestTask.new(:test => :test_app) do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

task :default => :test
