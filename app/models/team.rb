class Team < ApplicationRecord
  belongs_to :manager
  belongs_to :director
end
