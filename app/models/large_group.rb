class LargeGroup < ApplicationRecord
    has_many :discussionGroups

    # Validations
    validates_presence_of :date, :session_number, :semester
    validates_date :date, :on_or_before => Date.current
    validates_numericality_of :session_number, :only_integer => true, :greater_than_or_equal_to => 1
    validates_format_of :semester, :with => /([fs]|[FS])\d{2}/


    #Fall or Spring
    SEASON = [['f', :f],['s', :s]]

    # Scopes
    scope :for_semester, ->(sem) { where(semester: sem) }
    scope :by_created, -> { order("date") }

    
    
end
