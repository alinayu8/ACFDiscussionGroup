require "csv"

class Member < ApplicationRecord
  belongs_to :cellGroup
  has_many :memberDgs

  # Validations
  validates_inclusion_of :gender, in: %w( male female ), message: "is not recognized in the system"
  #validate :opt_cg_gender

  # Scopes
  scope :alphabetical, -> { order('name') }
  scope :for_gender, ->(gender) { where(gender: gender) }
  scope :for_cg, ->(cg) { where(cg: cellGroup) }
  scope :for_leader, ->(leader) { where(is_leader: true) }

  # Functions

  # cell group and gender optional as long as one of them are given
  # def opt_cg_gender
  #   if (cellGroup == nil) && (gender == nil)
  #     errors.add(:name, “must have either cell group or gender listed”)
  #   end
  # end

  # parse member text in order to create
  def member_list=(new_members)
    members = CSV.parse(new_members)
    members.each do |m|
      m = m.split(",").map(&:strip)
      if m.size == 2
        if m[1] in %w[male female]
          Member.create(:name => m[0], :gender => m[1])
        else
          Member.create(:name => m[0], :cellGroup => m[1])
      elsif m.size == 3
        Member.create(:name => m[0], :cellGroup => m[1], :gender => m[2])
      else
        errors.add(m[0], “must have either cell group or gender listed”)
      end
    end
  end
end
