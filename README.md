#DoozerCore

Start with the latest version of Ruby and Rails 4.1.1.
http://rubyonrails.org/download/

I believe everything will be installed with `bundle install` including mongo


##Mongo Install

###Local Mongo
If you want to run a local mongo instance (I suggest this for all dev work)

run monogodb by creating /data/db in your root dir and running `mongod`

###Compose (hosted Mongo)
`source .doozer_rc` from the root directory to load the MONGO_DB environment var

In the config/mongo.yml file comment out the following lines.

    <<: *defaults
    database: doozer_development

Uncomment or add the following lines (you need both)

    uri: <%= ENV['MONGOHQ_URL'] %>
    use_env_var: true

##Run

Run the web server using the `rails c` command

Browse to http://localhost:3000 (or whatever your local rails server is configured for)