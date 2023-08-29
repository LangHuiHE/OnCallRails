class DefaultApplicationMode < ApplicationRecord
  belongs_to :application
  belongs_to :priority
  belongs_to :mode
end
