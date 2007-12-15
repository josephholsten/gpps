require 'rake/rdoctask'

desc 'Generate HTML documentation'
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = "doc"
  rdoc.rdoc_files.include('README', 'src/**/*.rb')
  rdoc.options << "--quiet"
end