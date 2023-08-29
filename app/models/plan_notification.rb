class PlanNotification < ApplicationRecord
  belongs_to :plan
  belongs_to :target
  belongs_to :role
  belongs_to :priority
end
