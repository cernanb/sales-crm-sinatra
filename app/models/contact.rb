class Contact < ActiveRecord::Base
  validates :first_name, :last_name, :contact, :phone_number, presence: true
  belongs_to :household
end
