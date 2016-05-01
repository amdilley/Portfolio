class Post < ActiveRecord::Base
  validates_presence_of :body, :description, :title, :slug

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
end
