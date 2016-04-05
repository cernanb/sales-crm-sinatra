class Household < ActiveRecord::Base
  belongs_to :producer
  has_many :contacts
end
