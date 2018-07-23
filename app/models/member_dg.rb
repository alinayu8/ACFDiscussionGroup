class MemberDg < ApplicationRecord
  belongs_to :member
  belongs_to :discussionGroup

  # Validations
  validates_presence_of :member, :discussionGroup
  
end
