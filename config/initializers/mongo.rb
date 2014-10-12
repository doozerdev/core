config = YAML.load_file(Rails.root + 'config' + 'mongo.yml')[Rails.env]

if config['use_env_var']
  db = URI.parse(ENV['MONGO_URL'])
  db_name = db.path.gsub(/^\//, '')
  db_connection = Mongo::Connection.new(db.host, db.port).db(db_name)
  db_connection.authenticate(db.user, db.password) unless (db.user.nil? || db.password.nil?)
  MongoMapper.connection =db_connection
else
  MongoMapper.connection = Mongo::Connection.new(config['host'], config['port'], { :logger => Rails.logger })
end
















# MongoMapper.connection = Mongo::Connection.new(config['host'], config['port'], {
#   :logger         => Rails.logger
# })

# #MongoMapper.database = "#myapp-#{Rails.env}"
# MongoMapper.database = config['database']
# if config['username'].present?
#   MongoMapper.database.authenticate(config['username'], config['password'])
# end