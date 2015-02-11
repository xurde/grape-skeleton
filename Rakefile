Dir["#{File.dirname(__FILE__)}/lib/tasks/**/*.rake"].sort.each { |ext| load ext }

desc "Grape Routes"
task :routes do
  API::Base.routes.each do |api|
    method = api.route_method.ljust(10)
    path = api.route_path
    puts "   #{method} #{path}"
  end
end
