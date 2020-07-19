class User < ApplicationRecord
    has_many :user_properties
    has_many :properties, :through => :user_properties
end
