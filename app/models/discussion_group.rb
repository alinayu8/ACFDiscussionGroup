require 'pp'
class DiscussionGroup < ApplicationRecord
  belongs_to :largeGroup
  has_many :memberDgs
  
  # Validations
  validate :name_is_leaders_name

  # Scopes
  scope :for_lg, -> (lg) { where(largeGroup: lg) }
  scope :for_name, -> (name) { where(name: name) }
  scope :alphabetical, -> { order("name") }

  # Functions
  def name_is_leaders_name
    if !Member.all.for_leader.map(&:name).include?(self.name)
      errors.add(self.name, "is not the name of a leader")
    end
  end

  def leader
    return Member.for_leader.where(name: self.name).first
  end

  def gender
    return Member.for_leader.where(name: self.name).first.gender
  end

  # find the dg that has the least number of members
  def self.least_members(large_group, gender)
    least_members = nil
    dg = nil
    Member.for_leader.for_gender(gender).each do |mem|
      # members at the large group in a specific discussion group
      members = MemberDg.select {|mdg| (mdg.discussionGroup.name == mem.name) && (mdg.discussionGroup.largeGroup == large_group)}
      if least_members.nil? || members.count < least_members.count
        least_members = members
        dg = members.first.discussionGroup
      end
    end
    return dg
  end

  # initialize the discussion groups per cell group; distribute the unassociated members to appropriate dgs
  def self.initialize_dgs(large_group)
    # create dgs if don't exist
      Member.all.active.for_leader.each do |m|
        if DiscussionGroup.where(largeGroup: large_group).where(name: m.name).empty?
          @dg = DiscussionGroup.create!(name: m.name, largeGroup: large_group, randomized: false)
        else
          @dg = DiscussionGroup.where(largeGroup: large_group).where(name: m.name).first
        end
        # have to do this ugly call because cellGroup is optional
        Member.all.active.have_cg.select{ |mem| mem.cellGroup.name == m.cellGroup.name}.each do |m|
          MemberDg.create!(member: m, discussionGroup: @dg)
        end
      end  
    
    # assign the other members
    other_members = Member.all.active.no_cg
    other_members.each do |m|
      # assign by gender
      if m.gender == "Male"
        @dg = DiscussionGroup.least_members(large_group, "Male")
      else 
        @dg = DiscussionGroup.least_members(large_group, "Female")
      end
      MemberDg.create!(member: m, discussionGroup: @dg)
    end
  end

  # randomize the members of cell groups
  def self.randomize(large_group)
    array_1 = []
    array_2 = []

    # if not the first time randomizing dgs
    test_dg = DiscussionGroup.where(largeGroup: large_group).first
    if test_dg.randomized
      MemberDg.delete_all
      DiscussionGroup.initialize_dgs(large_group)
    end

    dgs = DiscussionGroup.all.where(largeGroup: large_group).alphabetical

    # shuffle each initial discussion group (cell group) and split into 2 halves
    dgs.each do |dg|
      dg.update_attributes(:randomized => true)
      dg_members = MemberDg.where(discussionGroup: dg).select { |mdg| mdg.member.is_leader == false}.shuffle # individual mdgs 
      leader = MemberDg.where(discussionGroup: dg).select { |mdg| mdg.member.is_leader == true}
      dg_members.unshift(leader)
      parts = (dg_members.size / 2.0).ceil
      split_groups = dg_members.each_slice(parts).to_a
      array_1.push(split_groups[0])
      dg_members.size == 1 ? index = [] : index = split_groups[1]
      array_2.push(index)
    end
    # ensure that last 2 in each half aren't the same
    until array_2.last.empty? || (dgs.last.name != array_2.last.last.discussionGroup.name)
      array_2.shuffle!
    end

    # compare first two dg halves to match
    dgs.each do |dg|
      dg_1 = array_1[0] # array of MDGs
      dg_2 = array_2[0]

      # "reshuffle" if both dgs halves are from the same dg
      if dg_2.nil? || dg_2[0].nil? || (dg.name == dg_2[0].discussionGroup.name)
          dg_2 = array_2[1]
      end

      # update dg_2 by reassigning to new dg
      if !dg_2.nil?
        dg_2.each do |mdg|
          mdg.update_attributes(:discussionGroup => dg)
        end
      end
      
      array_1.delete(dg_1)
      array_2.delete(dg_2)
    end
  end
end
