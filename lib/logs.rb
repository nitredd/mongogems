require 'mongo'
require 'json'

def get_logs(uri, filename)
  client = Mongo::Client.new(uri)
  cur = client.command getLog: 'global'
  rset = cur.to_a
  # rset = JSON.parse(JSON.dump(rset))
  File.open(filename, 'w') do |file|
    # file.puts rset
    rset.first['log'].each do |iter|
      file.write(JSON.dump(JSON.parse(iter)))
      file.write "\n"
    end
  end
end

get_logs 'mongodb://localhost', 'logs.txt'