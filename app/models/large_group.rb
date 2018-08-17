class LargeGroup < ApplicationRecord
    has_many :discussionGroups

    # Validations
    validates_presence_of :date, :session_number, :semester
    validates_date :date, :on_or_before => Date.current
    validates_numericality_of :session_number, :only_integer => true, :greater_than_or_equal_to => 1

    SEASON = [['Fall', :fall],['Spring', :spring],['Summer', :summer]]

    # Scopes
    scope :for_semester, ->(sem) { where(semester: sem) }
    scope :by_created, -> { order("created_at DESC") }
end
