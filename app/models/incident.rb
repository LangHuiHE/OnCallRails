class Incident < ApplicationRecord
  belongs_to :plan
  belongs_to :owner
  belongs_to :application
end
