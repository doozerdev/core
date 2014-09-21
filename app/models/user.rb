class User
  include MongoMapper::Document

  key :provider, String
  key :uid, String
  key :name, String
  key :oauth_token, String
  key :oauth_expires_at, DateTime

  def self.from_omniauth(auth)
    first_or_create(auth.slice(:provider, :uid)).tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

end
