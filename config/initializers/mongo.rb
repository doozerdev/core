MongoMapper.connection = Mongo::Connection.new(ENV['MONGOHQ_URL'])
MongoMapper.database = "#myapp-#{Rails.env}"
