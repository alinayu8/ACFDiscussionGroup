class Member < ApplicationRecord
  belongs_to :cellGroup, optional: true
  has_many :memberDgs

  #attr_accessor :name, :cellGroup, :gender

  # Validations
  validates_presence_of :name, :gender, :year
  validates_inclusion_of :gender, in: %w(  Male Female ), message: "is not recognized in the system"
  validate :gender_matches_cg
  validate :cg_exists

  # Scopes
  scope :alphabetical, -> { order('name') }
  scope :for_gender, ->(gender) { where(gender: gender) }
  scope :for_cg, ->(cg) { where(cg: cellGroup) }
  scope :for_leader, -> { where(is_leader: true) }
  scope :no_cg, -> { where(cellGroup: nil) }
  scope :have_cg, -> { where.not(cellGroup: nil) }
  scope :for_graduates, ->{ where(year > 4) }
  scope :active, ->{ where(is_active: true) }

  # Functions
  def gender_matches_cg
    if self.cellGroup != nil 
      self.gender == self.cellGroup.gender
    end
  end

  def cg_exists
    if self.cellGroup != nil 
      CellGroup.all.include?(self.cellGroup)
    end
  end

  def self.add_one_year
    Member.update_all("year = year + 1")
  end

  # parse member text in order to create new members
  # assumming members will be listed out as: Name, Year, Cell Group, Gender OR Name, Year, Cell Group OR Name, Year, Gender
  def self.member_list(new_members)
    create_members = []
    members = new_members.strip.split("\n")
    members.each do |m|
      m = m.split(",").map(&:strip).reject(&:empty?)
      if m.size == 3
       if %w[male female Male Female].include?(m[2])
          @gender = m[2]
        else
          @gender = CellGroup.find_by(name: m[2]).gender
          @cg = CellGroup.find_by(name: m[2])
        end
      elsif m.size == 4
        @cg = CellGroup.find_by(name: m[2])
        if @cg == nil
          return "cell group name invalid"
        end
          @gender = m[3]
      else
        return "must have either cell group or gender listed as well as year, and information must be in proper order"
      end
      @gender.capitalize!
      @name = m[0]
      @year = m[1]
      create_members.push(Member.new(:name => @name, :year => @year, :gender => @gender, :cellGroup => @cg))
      @gender = nil # reset variables
      @cg = nil
    end
    create_members.map {|member| member.save! } 
  end
end
