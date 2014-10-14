#DoozerCore

Start with the latest version of Ruby and Rails 4.1.1.
http://rubyonrails.org/download/

I believe everything will be installed with `bundle install` including mongo


##Mongo Install

`source .doozer_rc` from the root directory to load the MONGO_DB environment var

If you want this to happen every time, move the .doozer_rc file to your home directory and add the following line to your .bashrc or .bash_profile

    if [ -f ~/.doozer_rc ]; then . ~/.doozer_rc; fi

This will load three values into your environment: `MONGOHQ_URL`, `FB_APP_ID`, `FB_APP_SECRET`. You don't need the first one to run locally, but you'll need the second two to authenticate to Facebook. 

###Local Mongo
If you want to run a local mongo instance (I suggest this for all dev work)

run monogodb by creating /data/db in your root dir and running `mongod`

###Compose (hosted Mongo)

In the config/mongo.yml file comment out the following lines.

    <<: *defaults
    database: doozer_development

Uncomment or add the following lines (you need both)

    uri: <%= ENV['MONGOHQ_URL'] %>
    use_env_var: true

##Run

Run the web server using the `rails c` command

Browse to http://localhost:3000 (or whatever your local rails server is configured for)