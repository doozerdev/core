if Rails.env.production?
  MongoMapper.connection = Mongo::Connection.new(ENV['MONGOHQ_URL'])
else
  MongoMapper.connection = Mongo::Connection.new('localhost', 27017)  
end

MongoMapper.database = "#myapp-#{Rails.env}"
