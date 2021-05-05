Gem::Specification.new do |spec|
  spec.authors = ["Katkam Nitin Reddy"]
  spec.name = "mongogems"
  spec.version = "0.0.3"
  spec.date = '2021-05-04'
  spec.summary = "MongoDB Utilities"
  spec.files = ['lib/savedPipeline.rb', 'lib/logs.rb']
  spec.require_paths = ["lib"]
  spec.executables=['compass2mongosh', 'mongolog2file']
  spec.add_dependency "mongo", "~> 2.14.0"
end
