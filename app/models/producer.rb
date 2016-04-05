class Producer < ActiveRecord::Base
  has_secure_password
  has_many :households
  has_many :contacts, through: :households
end
