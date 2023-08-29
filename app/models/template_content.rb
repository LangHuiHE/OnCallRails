class TemplateContent < ApplicationRecord
  belongs_to :template
  belongs_to :application
  belongs_to :mode
end
