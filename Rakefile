require 'rake/testtask'
require 'rake/gempackagetask'

desc 'Prepare testing by creating test app'
task :test_app do
  sh "rails -q -m test/test_app_template.rb test/test_app" unless
    File.exists? 'test/test_app'
end

spec = eval File.read('user_list.gemspec')
Rake::GemPackageTask.new spec do |pkg|
  pkg.need_tar = false
end

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

task :default => :test
