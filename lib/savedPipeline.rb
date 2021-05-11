require 'json'
# require 'hjson'

# filename = '/Users/nitin/Downloads/Zaloni-DQ-A/607d7460cb21963a143d1d0f.json'

def pipeline_to_mongosh_script(infile, outfile)
  txt = File.read(infile)
  data = JSON.parse(txt)

  ns_split = data['namespace'].split '.', 2
  dbname = ns_split[0]
  collname = ns_split[1]

  the_pipeline = "[\n"
  is_first = true
  data['pipeline'].each do |pstage|
    if not pstage["isEnabled"]
      next
    end

    if is_first
      is_first = false
    else
      the_pipeline += ', '
    end
    stage_txt = pstage['stage']
    stage_txt = stage_txt.gsub("\\r", "\r").gsub("\\n", "\n")
    the_pipeline += "{ #{pstage['stageOperator']}: " + stage_txt + " }"
  end
  the_pipeline += "\n]"

  mongosh_script_out =
"//Query name: #{data['name']}

db.getSiblingDB('#{dbname}').#{collname}.aggregate(
" + the_pipeline + "
, {allowDiskUse: true}
);
"

  File.write(outfile, mongosh_script_out)
end

# pipeline_to_mongosh_script filename, '/dev/null'
