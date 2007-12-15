# Load all rakefile extensions
Dir["#{File.dirname(__FILE__)}/*.rake"].each { |ext| load ext }
Dir["#{File.dirname(__FILE__)}/deliverables/*.rake"].each { |ext| load ext }