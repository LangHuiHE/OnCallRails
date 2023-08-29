class CategoryOverride < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :mode
end
