class User < ApplicationRecord
  devise  :omniauthable,
          :database_authenticatable, 
          :registerable,
          :recoverable, 
          :rememberable, 
          :validatable,
          :jwt_authenticatable, 
          jwt_revocation_strategy: JwtDenylist,
          omniauth_providers: [:google_oauth2]

  def self.from_omniauth access_token
    data = access_token.info
    User.where(email: data["email"])
            .first_or_create(email: data["email"],
                            password: Devise.friendly_token[0, 20],
                            provider: access_token[:provider],
                            uid: access_token[:uid])
  end
end
