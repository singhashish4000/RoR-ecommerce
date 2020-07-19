class Property < ApplicationRecord
    has_many :user_properties
    has_many :users, :through => :user_properties
end
