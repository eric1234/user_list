Gem::Specification.new do |s|
  s.name = 'user_list'
  s.version = '0.2.0'
  s.author = 'Eric Anderson'
  s.email = 'eric@pixelwareinc.com'
  s.add_dependency 'rails'
  s.files = Dir['**/*'].reject do |f|
    f =~ /^test/ || f == 'user_list.gemspec' || f =~ /^pkg/
  end
  s.extra_rdoc_files << 'README'
  s.rdoc_options << '--main' << 'README'
  s.summary = 'A simple Rails addon for managing users'
  s.description = <<-DESCRIPTION
    Provides a drop-in user management. Functionality is limited to
    adding, editing and deleting users. The data editable is very simple
    (email, password, etc.). If you need more then you probably need
    something more custom to your app.
  DESCRIPTION
end
