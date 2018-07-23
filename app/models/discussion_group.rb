class DiscussionGroup < ApplicationRecord
  belongs_to :largeGroup
  
  # Validations
  validate
end
