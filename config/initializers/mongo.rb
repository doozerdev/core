config = YAML.load_file(Rails.root + 'config' + 'mongo.yml')[Rails.env]

# MongoMapper.connection = Mongo::Connection.new(ENV['MONGOHQ_URL'])
MongoMapper.connection = Mongo::Connection.new(config['host'], config['port'], {
  :logger         => Rails.logger
})

#MongoMapper.database = "#myapp-#{Rails.env}"
MongoMapper.database = config['database']
if config['username'].present?
  MongoMapper.database.authenticate(config['username'], config['password'])
end