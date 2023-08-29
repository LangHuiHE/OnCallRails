class DynamicPlanMap < ApplicationRecord
  belongs_to :incident
  belongs_to :role
  belongs_to :target
end
