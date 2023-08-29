class TargetMode < ApplicationRecord
  belongs_to :target
  belongs_to :priority
  belongs_to :mode
end
