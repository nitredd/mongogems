require 'mongo'
require 'json'

def get_indexes_script(uri, db_name=nil, coll_name=nil, outfile)
  client = Mongo::Client.new(uri)

  db_list = []
  if not db_name.nil?
    db_list.push db_name
  else
    client.use('admin').command(listDatabases: 1).first['databases'].each do |iter|  # read the name property
      iter_db_name = iter['name']
      db_list.push iter_db_name
    end
  end

  scripts = []

  db_list.each do |iter_db|
    client = client.use iter_db
    scripts.push "db = db.getSiblingDB('#{iter_db}')';"
    if coll_name.nil?
      colls = client.collections
    else
      colls = [
        client[coll_name]
      ]
    end

    colls.each do |coll|
      coll.indexes.each do |idx|

        #Skip the _id index
        l_idx_cols = idx['key'].to_h.keys
        if l_idx_cols.length == 1 and l_idx_cols.first == '_id'
          next
        end

        txt = gen_idx_script idx, coll.name
        scripts.push txt
      end
    end
  end

  txtscripts = scripts.join "\r\n"

  File.open outfile, 'w' do |f|
    f.write txtscripts
  end
end

def gen_idx_script(idIndex, collname)
  idx_name = idIndex['name']
  idx_spec = JSON.dump(idIndex['key'])
  idx_options = {}
  idIndex.each do |k, v|
    if ['v', 'key'].include? k then
      next
    end
    idx_options[k] = v
  end
  opt_spec = JSON.dump idx_options
  txt = "db.#{collname}.createIndex(#{idx_spec}, #{opt_spec});"
end
