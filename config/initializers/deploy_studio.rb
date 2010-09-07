ds_config_file = File.dirname(__FILE__) + '/../ds-database.yml'
ds_config = YAML.load_file(ds_config_file)[ENV[RAILS_ENV] || 'development']

DS_URL = ds_config['url']
DS_USERNAME = ds_config['username']
DS_PASSWORD = ds_config['password']

DS_CONNECTION = RestClient::Resource.new DS_URL, DS_USERNAME, DS_PASSWORD
