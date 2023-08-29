class TargetApplicationMode < ApplicationRecord
  belongs_to :target
  belongs_to :application
  belongs_to :priority
  belongs_to :mode
end
