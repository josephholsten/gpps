STATS_DIRECTORIES = [
  %w(Code               src/),
  %w(Tasks              tasks/),
  %w(Examples           examples/)
].collect { |name, dir| [ name, "#{GPPS_ROOT}/#{dir}" ] }.select { |name, dir| File.directory?(dir) }

desc "Report code statistics (KLOCs, etc) from the application"
task :stats do
  require 'lib/code_statistics'
  CodeStatistics.new(*STATS_DIRECTORIES).to_s
end