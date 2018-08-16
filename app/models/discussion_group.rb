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

  # initialize the discussion groups per cell group; distribute the unassociated members to appropriate dgs
  def self.initialize_dgs(large_group)
    # create dgs
    Member.all.for_leader.each do |m|
      @dg = DiscussionGroup.create!(name: m.name, largeGroup: large_group)
      # have to do this ugly call because cellGroup is optional
      Member.all.have_cg.select{ |mem| mem.cellGroup.name == m.cellGroup.name}.each do |m|
        MemberDg.create!(member: m, discussionGroup: @dg)
      end
    end
    
    # assign the other members
    og_male_dgs = DiscussionGroup.all.select { |dg| Member.find_by(name: dg.name).gender == "male" }.shuffle
    og_female_dgs = DiscussionGroup.all.select { |dg| Member.find_by(name: dg.name).gender == "female" }.shuffle
    male_dgs = og_male_dgs
    female_dgs = og_male_dgs
    other_members = Member.all.no_cg
    other_members.each do |m|
      # "restock" dgs to assign
      if male_dgs.empty?
        male_dgs = og_male_dgs
      elsif female_dgs.empty?
        female_dgs = og_female_dgs
      end

      # assign by gender
      if m.gender == "male"
        @dg = male_dgs.first
        male_dgs.delete(male_dgs.first)
      else 
        @dg = female_dgs.first
        female_dgs.delete(female_dgs.first)
      end
      MemberDg.create!(member: m, discussionGroup: @dg)
    end
  end

  # randomize the members of cell groups
  def self.randomize(large_group)
    array_1 = []
    array_2 = []

    # if not the first time randomizing dgs
    test_dg = DiscussionGroup.all.where(largeGroup: large_group).first    
    test_mdg = MemberDg.where(discussionGroup: test_dg).first
    if test_mdg.updated_at != test_mdg.created_at
      del_mdgs = MemberDg.all.select { |mdg| mdg.discussionGroup.largeGroup == large_group}
      del_dgs = DiscussionGroup.all.where(largeGroup: large_group)
      MemberDg.delete(del_mdgs)
      DiscussionGroup.delete(del_dgs)
      DiscussionGroup.initialize_dgs(large_group)
    end

    dgs = DiscussionGroup.all.where(largeGroup: large_group).alphabetical

    # shuffle each initial discussion group (cell group) and split into 2 halves
    dgs.each do |dg|
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
