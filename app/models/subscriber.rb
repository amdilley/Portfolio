class Subscriber < ActiveRecord::Base
  extend FriendlyId
  friendly_id :email
end
