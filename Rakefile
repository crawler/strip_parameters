require "rake/testtask"
# require "action_dispatch"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/{controllers,libs}/*_test.rb"]
end

task default: :test
