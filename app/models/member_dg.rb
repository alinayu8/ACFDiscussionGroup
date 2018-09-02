class MemberDg < ApplicationRecord
  belongs_to :member
  belongs_to :discussionGroup

  # Validations
  validates_presence_of :member, :discussionGroup
  
  # Scopes
  scope :for_member, ->(member) { where(member: member) }
  scope :for_dg, ->(dg) { where(dg: discussionGroup) }
  scope :for_attended, ->{ where(attended: true) }
end
