MongoMapper.connection = Mongo::Connection.new('localhost', 12345)  

MongoMapper.database = "#myapp-#{Rails.env}"
