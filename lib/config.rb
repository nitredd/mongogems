require 'yaml'

$config_filename = File.join(Dir.home, '.mongogems')
$has_config = lambda { File.exists? $config_filename }

# Write a key-value pair to the config file
def write_config_entry(key, value)
  if $has_config.call then
    curr_config = YAML.load(File.read($config_filename))
  else
    curr_config = {}
  end

  curr_config[key] = value

  File.open($config_filename, 'w') { |f| f.write(curr_config.to_yaml) }
end

# Reads a key-value pair from the config file
def read_config_entry(key)
  if $has_config.call then
    curr_config = YAML.load(File.read($config_filename))
  else
    return nil
  end

  curr_config[key]
end

# write_config_entry 'mongouri', 'mongodb://localhost'
# p (read_config_entry 'mongouri')
