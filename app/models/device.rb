class Device < ApplicationRecord
  belongs_to :registration
  belongs_to :user
end
