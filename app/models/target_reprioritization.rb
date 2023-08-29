class TargetReprioritization < ApplicationRecord
  belongs_to :target
  belongs_to :src_mode
  belongs_to :dst_mode
end
