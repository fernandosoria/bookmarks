class Bookmark < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :likes, dependent: :destroy

  default_scope {order('created_at DESC')}
end
