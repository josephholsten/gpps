require 'spec/rake/spectask'

desc "Run examples using RCov"
Spec::Rake::SpecTask.new('examples') do |t|
  t.spec_files = FileList['examples/**/*.rb']
  # t.rcov       = true
  # t.rcov_opts  = %w(-t -x\ example)
  # t.warning    = true
end