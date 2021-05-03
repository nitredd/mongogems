require 'json'

# filename = '/Users/nitin/Downloads/Zaloni-DQ-A/607d7460cb21963a143d1d0f.json'

def pipeline_to_mongosh_script(infile, outfile)
  txt = File.read(infile)
  data = JSON.parse(txt)

  ns_split = data['namespace'].split '.', 2
  dbname = ns_split[0]
  collname = ns_split[1]

  the_pipeline = []
  data['pipeline'].each do |pstage|
    the_pipeline.push pstage['executor']
  end

  mongosh_script_out =
"
//Query name: #{data['name']}
use #{dbname};
db.#{collname}.aggregate(
#{JSON.generate the_pipeline}
, {allowDiskUse: true}
);
"

  File.write(outfile, mongosh_script_out)
end

# pipeline_to_mongosh_script filename, '/dev/null'
