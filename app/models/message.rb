class Message < ApplicationRecord
  belongs_to :application
  belongs_to :target
  belongs_to :mode
  belongs_to :plan
  belongs_to :priority
  belongs_to :incident
  belongs_to :plan_notification
  belongs_to :template
end
