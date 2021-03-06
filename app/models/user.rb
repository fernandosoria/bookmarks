class User < ActiveRecord::Base
  has_many :bookmarks
  has_many :likes, dependent: :destroy
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
    end
  end

  def role?(base_role)
    role == base_role.to_s
  end

  def liked(bookmark)
    likes.where(bookmark_id: bookmark.id).first
  end
end
